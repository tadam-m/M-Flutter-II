var express = require('express');
var router = express.Router();

router.get('/getList', function (req, res, next)
{
    try {
        let response = getList(req);
        res.status(response.status).json(response.body);
    } catch (error) {
        console.log(error);
        res.status(500).json({message: "Internal error"});
    }
});

router.get('/getClub', function(req, res, next)
{
    try {
        let response = getClub(req);
        res.status(response.status).json(response.body);
    } catch (error) {
        console.log(error);
        res.status(500).json({message: "Internal error"});
    }
});

function getList(req)
{
    var username = req.body.username;

    if (username == undefined)
        return {status: 403, body: {message: "username is empty"}};
    if (global.UsersList.get(username) == undefined)
        return {status: 401, body: {message: "Bad request"}};
    return {status: 200, body: global.ClubList};
}

function getClub(req)
{
    var username = req.body.username;
    var club = req.body.club;

    if (username == undefined || club == undefined)
        return {status: 403, body: {message: "username or club is empty"}};
    var tmp = global.ClubList.get(club);
    if (tmp == undefined || global.UsersList.get(username) == undefined)
        return {status: 401, body: {message: "Bad request"}};
    return {status: 200, body: tmp};
}

module.exports = router;