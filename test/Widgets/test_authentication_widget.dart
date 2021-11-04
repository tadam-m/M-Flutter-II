import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techno_clubs_berlin/screens/auth/login_screen.dart';
import 'package:techno_clubs_berlin/screens/auth/register_screen.dart';

void testAuthWidgets() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(home: Scaffold(body: widget))
    );
  }
  LoginScreen loginScreen = const LoginScreen();
  RegisterScreen registerScreen = const RegisterScreen();

/*  Given the email or password is empty
  When the user taps on the login button
  Then we don't attempt to sign in
*/
  testWidgets('Login Widget has an input name, password and login button', (WidgetTester tester) async {

    await tester.pumpWidget(buildTestableWidget(loginScreen));
    Finder hintEmailText = find.byKey(const Key('email'));
    Finder hintPasswordText = find.byKey(const Key('password'));
    Finder loginButton = find.byKey(const Key('login'));

    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(loginButton, findsOneWidget);
  });

  testWidgets('Register Widget has an input name, password and login button', (WidgetTester tester) async {

    await tester.pumpWidget(buildTestableWidget(registerScreen));
    Finder hintUsernameText = find.byKey(const Key('usernameRegister'));
    Finder hintEmailText = find.byKey(const Key('emailRegister'));
    Finder hintPasswordText = find.byKey(const Key('passwordRegister'));
    Finder loginButton = find.byKey(const Key('register'));

    expect(hintUsernameText, findsOneWidget);
    expect(hintEmailText, findsOneWidget);
    expect(hintPasswordText, findsOneWidget);
    expect(loginButton, findsOneWidget);
  });
}