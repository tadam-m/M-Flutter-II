var express = require("express");
var router = express.Router();
var uuid = require("uuid");

router.post("/PostReview", function (req, res, next) {
  try {
    let response = PostReview(req);
    res.status(response.status).json(response.body);
  } catch (error) {
    return { status: 500, body: { message: { message: "Internal error" } } };
  }
});

router.post("/DeleteReview", function (req, res, next) {
  try {
    let response = DeleteReview(req);
    res.status(response.status).json(response.body);
  } catch (error) {
    return { status: 500, body: { message: { message: "Internal error" } } };
  }
});
router.get("/GetReview", function (req, res, next) {
  try {
    let response = GetReview(req);
    res.status(response.status).json(response.body);
  } catch (error) {
    return { status: 500, body: { message: { message: "Internal error" } } };
  }
});
function GetReview(req) {
  var club = req.body.club;

  if (club == undefined)
    return {
      status: 403,
      body: { message: { message: "club is undefined" } },
    };
  var tmp = global.ClubList.get(club);
  if (tmp == undefined)
    return { status: 401, body: { message: { message: "Bad request" } } };
  return { status: 200, body: tmp.reviews };
}

function DeleteReview(req) {
  var uuid = req.body.uuid;
  var club = req.body.club;

  if (club == undefined || uuid == undefined)
    return {
      status: 403,
      body: { message: { message: "username, club or review is undefined" } },
    };
  var tmp = global.ClubList.get(club);
  if (tmp == undefined)
    return { status: 401, body: { message: { message: "Bad request" } } };
  let i = 0;
  for (; tmp.reviews[i]; i++) {
    console.log(tmp.reviews[i]);
    if (tmp.reviews[i].uuid == uuid) break;
  }
  if (i >= tmp.reviews.lenght)
    return { status: 401, body: { message: { message: "Bad request" } } };
  global.ClubList.get(club).reviews.splice(i, 1);
  return { status: 200, body: global.ClubList.get(club) };
}
function PostReview(req) {
  var username = req.body.reviewerName;
  var reviewContent = req.body.reviewContent;
  var mark = req.body.mark;
  var date = req.body.date;
  var club = req.body.club;

  if (
    reviewContent == undefined ||
    mark == undefined ||
    Number(mark) == "NaN" ||
    username == undefined ||
    club == undefined
  )
    return {
      status: 403,
      body: { message: { message: "Username, club or review is undefined" } },
    };
  var tmp = global.ClubList.get(club);
  if (tmp == undefined)
    return { status: 401, body: { message: { message: "Unknown club" } } };
  global.ClubList.get(club).reviews.push({
    uuid: uuid.v1(),
    reviewerName: username,
    reviewContent: reviewContent,
    mark: mark,
    date: date,
  });
  return { status: 200, body: global.ClubList.get(club) };
}

module.exports = router;
