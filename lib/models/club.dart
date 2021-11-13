import 'package:review/review.dart';

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
  String price;
  Entrance entrance;
  String clubbingTime;
  double? rating;
  List<Review> reviews;

  Club({
    required this.name,
    required this.description,
    required this.location,
    required this.camera,
    required this.price,
    required this.entrance,
    required this.clubbingTime,
    required this.rating,
    required this.reviews,
  });
}
