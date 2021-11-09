var express = require('express');
var router = express.Router();
var users = new Map();
var Response = require('../object/response.js').Response;

router.post('/login', function (req, res, next)
{
    let response = login(req);
    res.status(response.status).json(response.body);
});

router.post('/register', function (req, res, next)
{
    let response = register(req);
    res.status(response.status).json(response.body);
});

function register(req)
{
    var username = req.body.username;
    var password = req.body.password;

    if (username == undefined || password == undefined)
        return new Response(403, "username or password is empty");
    if (users.get(username) != undefined)
        return new Response(401, "This user already exist");
    else
        users.set(username, password);
    return new Response(200, "User " + username + " well created");
}

function login(req)
{
    console.log(req);
    var username = req.body.username;
    var password = req.body.password;
    if (username == undefined || password == undefined)
        return new Response(403, "username or password is empty");
    if (users.get(username) == password)
        return new Response(200, "You are now connected");
    else
        return new Response(401, "The username and password doesn't match");
}
module.exports = router;