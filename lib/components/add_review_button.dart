import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:review/review.dart';
import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:http/http.dart' as http;
import 'package:techno_clubs_berlin/models/club.dart';

class AddReviewButton extends StatefulWidget {
  final Club club;
  const AddReviewButton({Key? key, required this.club}) : super(key: key);

  @override
  _AddReviewButtonState createState() => _AddReviewButtonState();
}

class _AddReviewButtonState extends State<AddReviewButton> {
  final ApiManager _apiProvider = ApiManager(client: http.Client());

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final review = await showReviewForm(context);
          if (review == null) {
            return;
          }
          _apiProvider.addReview(review, widget.club.name);
        },
        icon: const Icon(Icons.add));
  }
}
