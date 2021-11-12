import 'package:flutter/material.dart';

class DisplayRating extends StatelessWidget {
  final double rating;

  const DisplayRating(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    double rest = rating - fullStars;
    int emptyStars = (5 - rating).floor();

    late bool half = false;

    if (rest > 0.7) {
      fullStars++;
    } else if (rest == 0.0) {
    } else if (rest < 0.3) {
      emptyStars++;
    } else {
      // between 0.3 and 0.7
      half = true;
    }

    final List<IconData> allStars = [];

    allStars.addAll(List.generate(fullStars, (i) => Icons.star_rate));
    if (half) allStars.add(Icons.star_half);
    allStars.addAll(List.generate(emptyStars, (i) => Icons.star_rate_outlined));

    return Row(
      children: allStars.map<Icon>((i) => Icon(i)).toList(),
    );
  }
}
