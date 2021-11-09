var express = require('express');
var router = express.Router();

router.post('/PostComment', function (req, res, next)
{
    try {
    let response = PostComment(req);
    res.status(response.status).json(response.body);
    } catch (error) {
        return {status: 500, body: {message: {message : "Internal error"}}};
    }
});

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
    var username = req.body.username;
    var club = req.body.club;
    var review = req.body.review;

    if (review == undefined || Number(review) == 'NaN' || username == undefined || club == undefined)
        return {status: 403, body: {message: {message : "username, club or review is undefined"}}};
    var tmp = global.ClubList.get(club);
    if (tmp == undefined || global.UsersList.get(username) == undefined)
        return {status: 401, body: {message: {message :  "Bad request"}}};
    var rate = tmp.rate * tmp.reviews;
    tmp.reviews++;
    tmp.rate = (rate + review) / tmp.reviews;
    global.ClubList.set(club, tmp);
    return {status: 200, body: tmp};
}

function PostComment(req)
{
    var username = req.body.username;
    var club = req.body.club;
    var review = req.body.review;

    if (username == undefined || club == undefined || review == undefined)
        return {status: 403, body: {message: "username, club or review is empty"}};
    var tmp = global.ClubList.get(club);
    if (tmp == undefined || global.UsersList.get(username) == undefined)
        return {status: 401, body: {message: "Bad request"}};
    tmp.comments.push(review);
    global.ClubList.set(club, tmp);
    console.log(global.ClubList.get(club));
    return {status: 200, body: tmp};
}
module.exports = router;