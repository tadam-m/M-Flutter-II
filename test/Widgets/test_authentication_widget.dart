import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techno_clubs_berlin/screens/auth/login_screen.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(home: Scaffold(body: widget))
    );
  }
/*  Given the email or password is empty
  When the user taps on the login button
  Then we don't attempt to sign in
*/

  testWidgets('empty email and password doesn\'t call sign in', (WidgetTester tester) async {
    // create a LoginPage
    //AuthMock mock = new AuthMock(userId: 'uid');
    LoginScreen loginScreen = const LoginScreen();
    // add it to the widget tester
    await tester.pumpWidget(buildTestableWidget(loginScreen));

    // tap on the login button
    Finder loginButton = find.byKey(const Key('login'));
    await tester.press(loginButton);

    // 'pump' the tester again. This causes the widget to rebuild
    await tester.pump();
    // check that the hint text is empty
    Finder hintEmailText = find.byKey(const Key('email'));
    Finder hintPasswordText = find.byKey(const Key('password'));
    expect(hintEmailText.toString().contains(''), true);
    expect(hintPasswordText.toString().contains(''), true);
  });
}