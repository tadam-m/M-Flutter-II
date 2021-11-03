import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:techno_clubs_berlin/models/user.dart';
import 'package:techno_clubs_berlin/API/custom_exception.dart';

class ApiManager
{
  static String baseUrl = 'https://gehensiezumclub.herokuapp.com/api/gehenSiezumClub';
  //http.Client client = http.Client();
  final http.Client client;
  ApiManager({required this.client});

  Future<User> loginUser(String username, String password) async {
    final response = await client.post(
      Uri.parse(baseUrl + '/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      }),
    );
    var responseJson = catchServerError(response);
    if (response.statusCode == 200) {
      return User(name: username, password: password);
    } else {
      throw Exception(responseJson.toString());
    }
  }

  Future<User> registerUser(String username, String password) async {
    final response = await client.post(
      Uri.parse(baseUrl + '/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      }),
    );
    var responseJson = catchServerError(response);
    if (response.statusCode == 200) {
      return User(name: username, password: password);
    } else {
      throw Exception(responseJson.toString());
    }
  }

  static dynamic catchServerError(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 401:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}