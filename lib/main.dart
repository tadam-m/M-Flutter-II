import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:techno_clubs_berlin/screens/auth/register_screen.dart';
import 'package:techno_clubs_berlin/themes/themes.dart';
import 'package:techno_clubs_berlin/screens/splash_screen.dart';
import 'package:techno_clubs_berlin/screens/auth/login_screen.dart';
import 'constants/routes.dart';
import 'screens/vue_club_list_screen.dart';

void main() {
  runApp(const MyApp());
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
          page: () => const RegisterScreen(),
        ),
        GetPage<VueClubListScreen>(
          name: vueListClub,
          page: () => const VueClubListScreen(),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: OfflineBuilder(
              connectivityBuilder: (
                context,
                connectivity,
                child,
              ) {
                if (connectivity == ConnectivityResult.none) {
                  return const Text('Oops, \n\nNow we are Offline!');
                } else {
                  return child;
                }
              },
              builder: (context) => const Routing(),
            ),
          );
        },
      ),
    );
  }
}
