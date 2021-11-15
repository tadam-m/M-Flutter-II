var express = require("express");
var router = express.Router();

router.get("/getList", function (req, res, next) {
  try {
    let response = getList(req);
    res.status(response.status).json(response.body);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal error" });
  }
});

router.get("/getClub", function (req, res, next) {
  try {
    let response = getClub(req);
    res.status(response.status).json(response.body);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal error" });
  }
});

function getList(req) {
  return { status: 200, body: Array.from(global.ClubList.values()) };
}

function getClub(req) {
  var club = req.body.club;

  if (club == undefined)
    return { status: 403, body: { message: "club is empty" } };
  var tmp = global.ClubList.get(club);
  if (tmp == undefined)
    return { status: 401, body: { message: "Bad request" } };
  return { status: 200, body: tmp };
}

module.exports = router;
