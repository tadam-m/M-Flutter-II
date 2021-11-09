var express = require('express');
var router = express.Router();
var Response = require('../object/response.js').Response;

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
        return new Response(403, {message: "username is empty"});
    if (global.UsersList.get(username) == undefined)
        return new Response(401, {message: "Bad request"});
    return new Response(200, global.ClubList);
}

function getClub(req)
{
    var username = req.body.username;
    var club = req.body.club;

    if (username == undefined || club == undefined)
        return new Response(403, {message: "username or club is empty"});
    var tmp = global.ClubList.get(club);
    if (tmp == undefined || global.UsersList.get(username) == undefined)
        return new Response(401, {message: "Bad request"});
    return new Response(200, tmp);


}
module.exports = router;