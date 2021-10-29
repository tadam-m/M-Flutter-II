var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var ManageAccount = require('./routes/ManageAccount');
var ReadClubFile = require('./bin/OpenClubList');
global.ClubList = [];

global.ClubList = ReadClubFile.ReadClubFile();
var app = express();
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/api/gehenSiezumClub', ManageAccount);

module.exports = app;