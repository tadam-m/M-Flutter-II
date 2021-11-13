#!/usr/bin/env node
var http = require("http");
var app = require("../index");
var port = process.env.PORT || 4000;

app.set("port", port);
var server = http.createServer(app);
server.listen(port);
server.on("error", Error);
server.on("listening", Listen);

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
