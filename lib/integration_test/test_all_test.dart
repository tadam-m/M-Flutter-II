import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

import 'auth_test.dart';
import 'list_view_clubs_test.dart';

Future<void> main() async {
  testAll();
}

Future<void> testAll() async {
  Get.testMode = true;
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});
  authTest();
  tearDown(() async {});
  setUp(() {});
  registerTest();
  tearDown(() async {});
  setUp(() {});
  clubsListViewTest();
  tearDown(() async {});
  setUp(() {});
  clubsListViewTestScroll();
  tearDown(() async {});
}
