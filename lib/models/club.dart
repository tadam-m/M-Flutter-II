enum Entrance {
  easy,
  medium,
  hard,
}

class Club {
  String name;
  String description;
  String location;
  bool camera;
  double rating;
  String price;
  Entrance entrance;
  String clubbingTime;

  Club({
    required this.name,
    required this.description,
    required this.location,
    required this.camera,
    required this.rating,
    required this.price,
    required this.entrance,
    required this.clubbingTime,
  });
}
