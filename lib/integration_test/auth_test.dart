import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/bloc/bloc_provider.dart';
import 'package:techno_clubs_berlin/bloc/club_list.dart';
import 'package:techno_clubs_berlin/bloc/selected_club.dart';
import 'package:techno_clubs_berlin/main.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

final randomCredentials = String.fromCharCodes(
    List.generate(5, (index) => Random().nextInt(33) + 89));

Future<void> authTest() async {
  final _clubListBloc = ClubListBloc(ApiManager(client: http.Client()));
  final _selectedClubBloc = SelectedClubBloc();
  testWidgets("Register in test example", (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider(
        bloc: _clubListBloc,
        child: BlocProvider(
          bloc: _selectedClubBloc,
          child: const Routing(),
        )));
    await tester.pumpAndSettle();

    Finder goToRegisterButton = find.byKey(const Key('goToRegister'));

    await tester.tap(goToRegisterButton);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    Finder hintUsernameText = find.byKey(const Key('usernameRegister'));
    Finder hintEmailText = find.byKey(const Key('emailRegister'));
    Finder hintPasswordText = find.byKey(const Key('passwordRegister'));
    Finder registerButton = find.byKey(const Key('register'));

    expect(hintUsernameText, findsOneWidget);
    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);

    await tester.enterText(hintUsernameText, randomCredentials);
    await tester.enterText(hintEmailText, randomCredentials + "@gmail.com");
    await tester.enterText(hintPasswordText, randomCredentials);

    await tester.tap(registerButton);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);
  });
}

Future<void> registerTest() async {
  final _clubListBloc = ClubListBloc(ApiManager(client: http.Client()));
  final _selectedClubBloc = SelectedClubBloc();
  testWidgets("Login in test example", (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider(
        bloc: _clubListBloc,
        child: BlocProvider(
          bloc: _selectedClubBloc,
          child: const Routing(),
        )));
    await tester.pumpAndSettle();

    Finder hintEmailText = find.byKey(const Key('email'));
    Finder hintPasswordText = find.byKey(const Key('password'));
    Finder loginButton = find.byKey(const Key('login'));

    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(loginButton, findsOneWidget);

    await tester.enterText(hintEmailText, randomCredentials);
    await tester.enterText(hintPasswordText, randomCredentials);

    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);
  });
}
