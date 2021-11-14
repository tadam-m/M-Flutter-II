import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techno_clubs_berlin/main.dart';
import 'dart:math';

Future<void> clubsListViewTest() async {
  final randomCredentials = String.fromCharCodes(
      List.generate(5, (index) => Random().nextInt(33) + 89));

  testWidgets("Test ListView is displaying first elements correctly",
      (WidgetTester tester) async {
    await tester.pumpWidget(const Routing());
    await tester.pumpAndSettle();

    Finder goToRegisterButton = find.byKey(const Key('goToRegister'));

    await tester.tap(goToRegisterButton);
    print("button go to register tapped");
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
    print("button register tapped");
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(ListView), findsOneWidget);

    final firstClubFinder = find.text("Berghain");
    final secondClubFinder = find.text("Anomalie Art Club");
    final thirdClubFinder = find.text("://about blank");
    final fourClubFinder = find.text("Loophole Berlin");

    expect(firstClubFinder, findsOneWidget);
    expect(secondClubFinder, findsOneWidget);
    expect(thirdClubFinder, findsOneWidget);
    expect(fourClubFinder, findsOneWidget);
  });

  testWidgets("Test ListView is scrollable and display last elements",
      (WidgetTester tester) async {
    await tester.pumpWidget(const Routing());
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
    print("button login tapped");
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(ListView), findsOneWidget);

    final firstClubFinder = find.text("Berghain");
    expect(firstClubFinder, findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pump();

    expect(firstClubFinder, findsNothing);
    final lastClubFinder = find.text("Suicide Club");
    expect(lastClubFinder, findsOneWidget);
  });
}
