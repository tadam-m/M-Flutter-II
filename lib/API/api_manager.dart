import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:review/review.dart';
import 'dart:convert';

import 'package:techno_clubs_berlin/constants/routes.dart';
import 'package:techno_clubs_berlin/models/user.dart';
import 'package:techno_clubs_berlin/models/club.dart';
import 'package:techno_clubs_berlin/API/custom_exception.dart';

Entrance _translateEntrance(String entrance) {
  switch (entrance.toLowerCase()) {
    case "easy":
      return Entrance.easy;
    case "medium":
      return Entrance.medium;
    case "hard":
    case "very hard":
      return Entrance.hard;
    default:
      throw Exception("unknown difficulty: $entrance");
  }
}

class ApiManager {
  final String baseUrl = dotenv.env["API_URL"] ??
      "https://gehensiezumclub.herokuapp.com/api/gehenSiezumClub";
  final http.Client client;
  ApiManager({required this.client});

  Future<User> loginUser(String username, String password) async {
    await _handleServerDown(
      () => client.post(
        Uri.parse(baseUrl + '/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'username': username,
            'password': password,
          },
        ),
      ),
    );
    return User(name: username, password: password);
  }

  Future<User> registerUser(String username, String password) async {
    await _handleServerDown(
      () => client.post(
        Uri.parse(baseUrl + '/users/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'username': username,
            'password': password,
          },
        ),
      ),
    );
    return User(name: username, password: password);
  }

  Future<void> addReview(Review review, String clubName) async {
    await _handleServerDown(
        () => client.post(Uri.parse(baseUrl + "/Clubs/PostReview"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'reviewerName': review.reviewerName,
              'reviewContent': review.reviewContent,
              'mark': review.mark,
              'date': review.date.toIso8601String(),
              'club': clubName
            })));
  }

  Future<List<Club>> getClubs() async {
    final Iterable responseJson = await _handleServerDown(
      () => client.get(
        Uri.parse(baseUrl + '/Clubs/getList'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    return List<Club>.from(
      responseJson.map(
        (jsonClub) {
          final reviewsData = jsonClub["reviews"];
          final List<Review> reviews = reviewsData is List
              ? reviewsData
                  .map((jsonReview) => Review(
                        reviewerName: jsonReview["reviewerName"],
                        reviewContent: jsonReview["reviewContent"],
                        mark: jsonReview["mark"],
                        date: DateTime.parse(jsonReview["date"]),
                      ))
                  .toList()
              : List.empty();

          return Club(
            camera: jsonClub["camera"],
            clubbingTime: jsonClub["best clubbing times"],
            description: jsonClub["description"],
            entrance: _translateEntrance(jsonClub["difficulties to get in"]),
            location: jsonClub["location"],
            name: jsonClub["name"],
            price: jsonClub["price"],
            reviews: reviews,
            rating: reviews.isEmpty
                ? null
                : reviews.fold<double>(
                        0,
                        (previousValue, element) =>
                            previousValue + element.mark) /
                    reviews.length,
          );
        },
      ),
      growable: false,
    );
  }

  Future<dynamic> _handleServerDown(
    Future<http.Response> Function() httpCall,
  ) async {
    try {
      final response = await httpCall();
      _catchServerError(response);
      return json.decode(response.body.toString());
    } on CustomException {
      rethrow;
    } catch (e) {
      Get.toNamed(serverDown);
      rethrow;
    }
  }

  static void _catchServerError(http.Response response) {
    switch (response.statusCode) {
      case 200:
        break;
      case 401:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}',
        );
    }
  }
}
