import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:techno_clubs_berlin/constants/routes.dart';
import 'package:techno_clubs_berlin/screens/auth/login_screen.dart';
import 'package:techno_clubs_berlin/screens/auth/register_screen.dart';
import 'package:techno_clubs_berlin/screens/connectivity/protect_connectivity.dart';
import 'package:techno_clubs_berlin/screens/connectivity/server_down.dart';
import 'package:techno_clubs_berlin/screens/splash_screen.dart';
import 'package:techno_clubs_berlin/screens/vue_club_list_screen.dart';
import 'package:techno_clubs_berlin/themes/themes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
          page: () => const ProtectConnectivity(child: LoginScreen()),
        ),
        GetPage<RegisterScreen>(
          name: registerRoute,
          page: () => const ProtectConnectivity(child: RegisterScreen()),
        ),
        GetPage<VueClubListScreen>(
          name: vueListClub,
          page: () => const ProtectConnectivity(child: VueClubListScreen()),
        ),
        GetPage<ServerDown>(
          name: serverDown,
          page: () => const ServerDown(),
        ),
      ],
    );
  }
}
