const fs = require("fs");
var Club = require('../object/Club').Club;

function ReadClubFile()
{
    var jsonString = fs.readFileSync("./data/datafromclub.json", "utf8");
    var object = JSON.parse(jsonString);
    return object.clubs;

}

module.exports = {ReadClubFile};