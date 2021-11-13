var express = require("express");
<<<<<<< HEAD
=======
var path = require("path");
>>>>>>> b2a2b65954f8053fcde15ab046d076f24e8a1347
var cookieParser = require("cookie-parser");
var logger = require("morgan");
var ManageAccount = require("./routes/ManageAccount");
var GetList = require("./routes/GetClub");
<<<<<<< HEAD
var ManageReview = require("./routes/ManageReviews");
var ReadClubFile = require("./data/OpenClubList");
var port = process.env.PORT || 4000;
var http = require("http");
=======
var ReadClubFile = require("./bin/OpenClubList");
global.ClubList = [];
>>>>>>> b2a2b65954f8053fcde15ab046d076f24e8a1347

global.ClubList = [];
global.UsersList = new Map();
global.ClubList = ReadClubFile.ReadClubFile();

var app = express();
<<<<<<< HEAD
app.set("port", port);
var server = http.createServer(app);
server.listen(port);
server.on("error", Error);
server.on("listening", Listen);
=======
>>>>>>> b2a2b65954f8053fcde15ab046d076f24e8a1347
app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use("/api/gehenSiezumClub/users", ManageAccount);
app.use("/api/gehenSiezumClub/Clubs", GetList);
<<<<<<< HEAD
app.use("/api/gehenSiezumClub/Clubs", ManageReview);

function Error(error) {
  var bind = typeof port === "string" ? "Pipe " + port : "Port " + port;

  if (error.syscall !== "listen") throw error;
  switch (error.code) {
    case "EADDRINUSE":
      console.error(bind + "is already used by another program");
      process.exit(1);
    case "EACCES":
      console.error(bind + " requires elevated privileges");
      process.exit(1);
    default:
      throw error;
  }
}

function Listen() {
  var addr = server.address();
  var bind = typeof addr === "string" ? "pipe " + addr : "port " + addr.port;
  console.log("Listening on " + bind);
}
=======
>>>>>>> b2a2b65954f8053fcde15ab046d076f24e8a1347
module.exports = app;
