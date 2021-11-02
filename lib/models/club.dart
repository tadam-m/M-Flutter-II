import 'dart:math';

enum Entrance {
  easy,
  medium,
  hard,
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYy';
String randomString(int length) {
  Random random = Random.secure();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => _chars.codeUnitAt(
        random.nextInt(_chars.length),
      ),
    ),
  );
}

String randomName(int length) => "Club ${randomString(3)} ${randomString(5)}";

double randomRating() => Random.secure().nextInt(50) / 10.0;

Entrance randomEntrance() =>
    Entrance.values[Random.secure().nextInt(Entrance.values.length)];

String randomPrice() {
  Random random = Random.secure();
  final first = random.nextInt(5) + 10;
  final second = first + random.nextInt(5) + 1;
  return "$first - $second euros";
}

bool randomCamera() => Random.secure().nextBool();

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

  Club.random()
      : name = randomName(10),
        description = randomString(100),
        location = randomString(20),
        camera = randomCamera(),
        rating = randomRating(),
        price = randomPrice(),
        entrance = randomEntrance(),
        clubbingTime = "Saturday Night";
}
