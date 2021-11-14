import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'auth_test.dart';
import 'list_view_clubs_test.dart';

void main() {
  testAll();
}

Future<void> testAll() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  authTest();
  clubsListViewTest();
}
