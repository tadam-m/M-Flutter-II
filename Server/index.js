var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var ManageAccount = require('./routes/ManageAccount');
var GetList = require('./routes/GetClub');
var ManageReview = require('./routes/ManageReviews');
var ReadClubFile = require('./bin/OpenClubList');
global.ClubList = [];
global.UsersList = new Map();
global.ClubList = ReadClubFile.ReadClubFile();

var app = express();
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/api/gehenSiezumClub/users', ManageAccount);
app.use('/api/gehenSiezumClub/Clubs', GetList);
app.use('/api/gehenSiezumClub/Clubs', ManageReview);
module.exports = app;