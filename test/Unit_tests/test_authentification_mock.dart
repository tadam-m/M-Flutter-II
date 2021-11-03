import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/API/custom_exception.dart';
import 'package:techno_clubs_berlin/models/user.dart';
import 'test_authentication_mock.mocks.dart';

@GenerateMocks([http.Client])
main() {
  const baseUrl = 'https://gehensiezumclub.herokuapp.com/api/gehenSiezumClub';

  group('Test Authentication Request', () {
    group('Register Test', () {
      test('Returns a User if the register method completes successfully',
          () async {
        final client = MockClient();
// Use Mockito to return a successful response when it calls the
// provided http.Client.
        when(client.post(
          Uri.parse(baseUrl + '/users/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'username': "tadam", 'password': "tadam"}),
        )).thenAnswer((_) async => http.Response(
            File('test/test_ressources/random_user.json').readAsStringSync(),
            200));

        final api = ApiManager(client: client);
        final user = await api.registerUser("tadam", "tadam");

        expect(user, isInstanceOf<User>());
        expect(user.name, "tadam");
        expect(user.password, "tadam");
      });
    });

    test('throws a BadRequestException if the http call completes with an error 401',
        () async {
      final client = MockClient();
      const name = "";
      const pass = "";
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.post(
        Uri.parse(baseUrl + '/users/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': name, 'password': pass}),
      )).thenAnswer((_) async => http.Response('"Please verify your information"', 401));
      final api = ApiManager(client: client);
      try {
        await api.registerUser(name, pass);
      } catch (e) {
        expect(e, isA<BadRequestException>());
      }
    });

    test('throws a UnauthorisedException if the http call completes with an error 403',
            () async {
          final client = MockClient();
          const name = "";
          const pass = "";
          // Use Mockito to return an unsuccessful response when it calls the
          // provided http.Client.
          when(client.post(
            Uri.parse(baseUrl + '/users/register'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'username': name, 'password': pass}),
          )).thenAnswer((_) async => http.Response('"Please verify your information"', 403));
          final api = ApiManager(client: client);
          try {
            await api.registerUser(name, pass);
          } catch (e) {
            expect(e, isA<UnauthorisedException>());
          }
    });

    test('throws a FetchDataException if the http call completes with an error 500',
            () async {
          final client = MockClient();
          const name = "";
          const pass = "";
          // Use Mockito to return an unsuccessful response when it calls the
          // provided http.Client.
          when(client.post(
            Uri.parse(baseUrl + '/users/register'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'username': name, 'password': pass}),
          )).thenAnswer((_) async => http.Response('"Error occured while Communication with Server"', 500));
          final api = ApiManager(client: client);
          try {
            await api.registerUser(name, pass);
          } catch (e) {
            expect(e, isA<FetchDataException>());
          }
        }
        );


    group('Login Test', () {
      test('Returns a User if the login method completes successfully',
              () async {
            final client = MockClient();
            const name = "tadam";
            const pass = "tadam";
// Use Mockito to return a successful response when it calls the
// provided http.Client.
            when(client.post(
              Uri.parse(baseUrl + '/users/login'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(
                  <String, String>{'username': name, 'password': pass}),
            )).thenAnswer((_) async => http.Response(
                File('test/test_ressources/random_user.json').readAsStringSync(),
                200));

            final api = ApiManager(client: client);
            final user = await api.loginUser(name, pass);

            expect(user, isInstanceOf<User>());
            expect(user.name, name);
            expect(user.password, pass);
          });
    });

    test('throws a BadRequestException if the http call completes with an error 401',
            () async {
          final client = MockClient();
          const name = "";
          const pass = "";
          // Use Mockito to return an unsuccessful response when it calls the
          // provided http.Client.
          when(client.post(
            Uri.parse(baseUrl + '/users/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'username': name, 'password': pass}),
          )).thenAnswer((_) async => http.Response('"Please verify your information"', 401));
          final api = ApiManager(client: client);
          try {
            await api.loginUser(name, pass);
          } catch (e) {
            expect(e, isA<BadRequestException>());
          }
        });

    test('throws a UnauthorisedException if the http call completes with an error 403',
            () async {
          final client = MockClient();
          const name = "";
          const pass = "";
          // Use Mockito to return an unsuccessful response when it calls the
          // provided http.Client.
          when(client.post(
            Uri.parse(baseUrl + '/users/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'username': name, 'password': pass}),
          )).thenAnswer((_) async => http.Response('"Please verify your information"', 403));
          final api = ApiManager(client: client);
          try {
            await api.loginUser(name, pass);
          } catch (e) {
            expect(e, isA<UnauthorisedException>());
          }
        });

    test('throws a FetchDataException if the http call completes with an error 500',
            () async {
          final client = MockClient();
          const name = "";
          const pass = "";
          // Use Mockito to return an unsuccessful response when it calls the
          // provided http.Client.
          when(client.post(
            Uri.parse(baseUrl + '/users/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'username': name, 'password': pass}),
          )).thenAnswer((_) async => http.Response('"Error occured while Communication with Server"', 500));
          final api = ApiManager(client: client);
          try {
            await api.loginUser(name, pass);
          } catch (e) {
            expect(e, isA<FetchDataException>());
          }
        }
    );
    });
}