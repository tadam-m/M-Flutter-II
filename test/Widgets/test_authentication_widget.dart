import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techno_clubs_berlin/screens/auth/login_screen.dart';
import 'package:techno_clubs_berlin/screens/auth/register_screen.dart';

void testAuthWidgets() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(home: Scaffold(body: widget)));
  }

  LoginScreen loginScreen = const LoginScreen();
  RegisterScreen registerScreen = const RegisterScreen();

/*  Given the email or password is empty
  When the user taps on the login button
  Then we don't attempt to sign in
*/
  testWidgets(
      'Login Widget handle empty form fields error and find all widgets on the screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(loginScreen));
    Finder hintEmailText = find.byKey(const Key('email'));
    Finder hintPasswordText = find.byKey(const Key('password'));
    Finder loginButton = find.byKey(const Key('login'));

    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pump();
    expect(find.text("Username is required"), findsOneWidget);
    expect(find.text("Password is required"), findsOneWidget);
  });

  testWidgets('Login Widget handle empty username only !',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(loginScreen));
    Finder hintEmailText = find.byKey(const Key('email'));
    Finder hintPasswordText = find.byKey(const Key('password'));
    Finder loginButton = find.byKey(const Key('login'));

    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(loginButton, findsOneWidget);
    await tester.enterText(hintPasswordText, 'testPasswordField');
    await tester.pump();

    await tester.tap(loginButton);
    await tester.pump();
    expect(find.text("Username is required"), findsOneWidget);
    expect(find.text("Password is required"), findsNothing);
  });

  testWidgets('Login Widget handle empty password only !',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(loginScreen));
    Finder hintEmailText = find.byKey(const Key('email'));
    Finder hintPasswordText = find.byKey(const Key('password'));
    Finder loginButton = find.byKey(const Key('login'));

    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(loginButton, findsOneWidget);
    await tester.enterText(hintEmailText, 'testEmailField');
    await tester.pump();

    await tester.tap(loginButton);
    await tester.pump();
    expect(find.text("Username is required"), findsNothing);
    expect(find.text("Password is required"), findsOneWidget);
  });

  testWidgets('Register Widget has an input name, password and login button',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(registerScreen));
    Finder hintUsernameText = find.byKey(const Key('usernameRegister'));
    Finder hintEmailText = find.byKey(const Key('emailRegister'));
    Finder hintPasswordText = find.byKey(const Key('passwordRegister'));
    Finder registerButton = find.byKey(const Key('register'));

    expect(hintUsernameText, findsOneWidget);
    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(registerButton, findsOneWidget);

    await tester.tap(registerButton);
    await tester.pump();

    expect(find.text("Username is required"), findsOneWidget);
    expect(find.text("Email is required"), findsOneWidget);
    expect(find.text("Password is required"), findsOneWidget);
  });

  testWidgets('Register Widget handle empty password only !',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(registerScreen));
    Finder hintUsernameText = find.byKey(const Key('usernameRegister'));
    Finder hintEmailText = find.byKey(const Key('emailRegister'));
    Finder hintPasswordText = find.byKey(const Key('passwordRegister'));
    Finder registerButton = find.byKey(const Key('register'));

    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(registerButton, findsOneWidget);

    await tester.enterText(hintUsernameText, 'testEmailField');
    await tester.enterText(hintEmailText, 'testUsernameField');
    await tester.pump();

    await tester.tap(registerButton);
    await tester.pump();

    expect(find.text("Username is required"), findsNothing);
    expect(find.text("Email is required"), findsNothing);
    expect(find.text("Password is required"), findsOneWidget);
  });
}
