import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/bloc/bloc_provider.dart';
import 'package:techno_clubs_berlin/bloc/club_list.dart';
import 'package:techno_clubs_berlin/bloc/selected_club.dart';
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
  runApp(const MainApplicationState());
}

class MainApplicationState extends StatefulWidget {
  const MainApplicationState({Key? key}) : super(key: key);

  @override
  _MainApplicationStateState createState() => _MainApplicationStateState();
}

class _MainApplicationStateState extends State<MainApplicationState> {
  final _clubListBloc = ClubListBloc(ApiManager(client: http.Client()));
  final _selectedClubBloc = SelectedClubBloc();

  @override
  void initState() {
    _clubListBloc.clubList.pipe(_selectedClubBloc.clubListSink);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _clubListBloc,
        child: BlocProvider(
          bloc: _selectedClubBloc,
          child: const Routing(),
        ));
  }
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
