var express = require('express');
var router = express.Router();
var Response = require('../object/response.js').Response;

router.post('/login', function (req, res, next)
{
    try {
        let response = login(req);
        res.status(response.status).json(response.body);
    } catch (error) {
        console.log(error);
        res.status(500).json({message: "Internal error"});
    }
});

router.post('/register', function (req, res, next)
{
    try {
        let response = register(req);
        res.status(response.status).json(response.body);
    } catch (error) {
        console.log(error);
        res.status(500).json({message: "Internal error"});
    }
});

function register(req)
{
    var username = req.body.username;
    var password = req.body.password;

    if (username == undefined || password == undefined)
        return new Response(403, {message: "username or password is empty"});
    if (global.UsersList.get(username) != undefined)
        return new Response(401, {message: "This user already exist"});
    global.UsersList.set(username, password);
    return new Response(200, {message: "User " + username + " well created"});
}

function login(req)
{
    console.log(req);
    var username = req.body.username;
    var password = req.body.password;
    if (username == undefined || password == undefined)
        return new Response(403, {message: "username or password is empty"});
    if (global.UsersList.get(username) == password)
        return new Response(200, {message : "You are now connected", username : username});
    else
        return new Response(401, {message: "The username and password doesn't match"});
}
module.exports = router;