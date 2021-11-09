var express = require('express');
var router = express.Router();
var Response = require('../object/response.js').Response;

router.post('/PostComment', function (req, res, next)
{
    try {
    let response = PostComment(req);
    res.status(response.status).json(response.body);
    } catch (error) {
        return new Response(500, {message : "Internal error"});
    }
});

router.post('/PostReview', function (req, res, next)
{
    try {
    let response = PostReview(req);
    res.status(response.status).json(response.body);
    } catch (error) {
        return new Response(500, {message : "Internal error"});
    }
});

function PostReview(req)
{
    var username = req.body.username;
    var club = req.body.club;
    var review = req.body.review;

    if (review == undefined || Number(review) == 'NaN' || username == undefined || club == undefined)
        return new Response(403, {message: "username, club or review is undefined"});
    var tmp = global.ClubList.get(club);
    if (tmp == undefined || global.UsersList.get(username) == undefined)
        return new Response(401, {message: "Bad request"});
    var rate = tmp.rate * tmp.reviews;
    tmp.reviews++;
    tmp.rate = (rate + review) / tmp.reviews;
    global.ClubList.set(club, tmp);
    return new Response(200, tmp);
}

function PostComment(req)
{
    var username = req.body.username;
    var club = req.body.club;
    var review = req.body.review;

    if (username == undefined || club == undefined || review == undefined)
        return new Response(403, {message: "username, club or review is empty"});
    var tmp = global.ClubList.get(club);
    if (tmp == undefined || global.UsersList.get(username) == undefined)
        return new Response(401, {message: "Bad request"});
    tmp.comments.push(review);
    global.ClubList.set(club, tmp);
    console.log(global.ClubList.get(club));
    return new Response(200, tmp);
}
module.exports = router;