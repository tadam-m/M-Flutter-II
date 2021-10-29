class Club {
    constructor(name, description, location, camera, price, time, difficulties) {
        this.name = name; 
        this.description = description;
        this.location = location;
        this.camera = camera == "Forbiden" ? false : true;
        this.price = price;
        this.time = time;
        this.difficulties = difficulties;
        this.comments = [""];
        this.rate = 0.0;
    }
}