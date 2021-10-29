const fs = require("fs");

function ReadClubFile()
{
    var jsonString = fs.readFileSync("./data/datafromclub.json", "utf8");
    var object = JSON.parse(jsonString);
    return object.clubs;
}

module.exports = {ReadClubFile};