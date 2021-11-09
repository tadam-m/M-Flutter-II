const fs = require("fs");

function ReadClubFile()
{
    var jsonString = fs.readFileSync("./data/datafromclub.json", "utf8");
    var object = JSON.parse(jsonString);
    var array = [];
    array = object.clubs;
    var tmp = new Map();
    for (var i in object.clubs) {
        tmp.set(object.clubs[i].name, object.clubs[i]);
    }
    return tmp;
}

module.exports = {ReadClubFile};