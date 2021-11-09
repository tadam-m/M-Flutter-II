var express = require('express');
var router = express.Router();

router.post('/PostReview', function (req, res, next)
{
    try {
    let response = PostReview(req);
    res.status(response.status).json(response.body);
    } catch (error) {
        return {status: 500, body: {message: {message : "Internal error"}}};
    }
});

function PostReview(req)
{
    var username = req.body.reviewerName;
    var reviewContent = req.body.reviewContent;
    var mark = req.body.mark;
    var date = req.body.date;
    var club = req.body.club;

    if (mark == undefined || Number(mark) == 'NaN' || username == undefined || club == undefined)
        return {status: 403, body: {message: {message : "username, club or review is undefined"}}};
    var tmp = global.ClubList.get(club);
    if (tmp == undefined || global.UsersList.get(username) == undefined)
        return {status: 401, body: {message: {message :  "Bad request"}}};
    var rate = tmp.rate * tmp.reviews;
    tmp.reviews++;
    tmp.rate = (rate + mark) / tmp.reviews;
    global.ClubList.get(club).commentaries.push({reviewerName: username, reviewContent: reviewContent, mark: mark, date : date});
    return {status: 200, body: global.ClubList.get(club)};
}

module.exports = router;