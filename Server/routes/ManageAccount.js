var express = require("express");
var router = express.Router();

router.post("/login", function (req, res, next) {
  try {
    let response = login(req);
    res.status(response.status).json(response.body);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal error" });
  }
});

router.post("/register", function (req, res, next) {
  try {
    let response = register(req);
    res.status(response.status).json(response.body);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal error" });
  }
});

function register(req) {
  var username = req.body.username;
  var password = req.body.password;

  if (username == undefined || password == undefined)
    return { status: 403, body: { message: "username or password is empty" } };
  if (global.UsersList.get(username) != undefined)
    return { status: 401, body: { message: "This user already exist" } };
  global.UsersList.set(username, password);
  return {
    status: 200,
    body: { message: "User " + username + " well created", username: username },
  };
}

function login(req) {
  var username = req.body.username;
  var password = req.body.password;

  if (username == undefined || password == undefined)
    return { status: 403, body: { message: "This user already exist" } };
  if (global.UsersList.get(username) == password)
    return {
      status: 200,
      body: { message: "You are now connected", username: username },
    };
  else
    return {
      status: 401,
      body: { message: "The username and password doesn't match" },
    };
}

module.exports = router;
