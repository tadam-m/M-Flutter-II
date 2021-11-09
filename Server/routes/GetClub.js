var express = require('express');
var router = express.Router();

router.get('/getList', function (req, res, next)
{
    res.status(200).json(global.ClubList);
});

module.exports = router;