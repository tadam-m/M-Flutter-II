import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_clubs_berlin/screens/auth/register_screen.dart';

import 'package:techno_clubs_berlin/themes/themes.dart';
import 'package:techno_clubs_berlin/screens/splash_screen.dart';
import 'package:techno_clubs_berlin/screens/auth/login_screen.dart';

import 'constants/routes.dart';

void main() {
  runApp(const Routing());
}

class Routing extends StatelessWidget {
  const Routing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes().darkTheme,
      initialRoute: '/',
      getPages: <GetPage<dynamic>>[
        GetPage<SplashScreen>(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage<LoginScreen>(
          name: loginRoute,
          page: () => const LoginScreen(),
        ),
        GetPage<RegisterScreen>(
          name: registerRoute,
          page: () => RegisterScreen(),
        ),
        // GetPage<LoginScreen>(
        //   name: loginRoute,
        //   page: () => LoginScreen(),
        // ),
        // GetPage<RegisterScreen>(
        //   name: registerRoute,
        //   page: () => RegisterScreen(),
        // ),
      ],
    );
  }
}

