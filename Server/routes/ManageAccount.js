var express = require('express');
var router = express.Router();
var users = new Map();
var Response = require('../bin/response.js').Response;

router.post('/login', function (req, res, next)
{
    res.json(login(req));
});

router.post('/register', function (req, res, next)
{
    res.json(register(req));
});

function register(req)
{
    if (users.get(req.body.username) != undefined)
        return new Response(401, "This user already exist");
    else
    {
        users.set(req.body.username, req.body.password);
        return new Response(200, "User " + req.body.username + " well created");
    }
}

function login(req)
{
    if (users.get(req.body.username) == req.body.password)
        return new Response(200, "You are now connected");
    else
        return new Response(401, "The username and password doesn't match");
}
module.exports = router;