import 'Unit_tests/test_authentification_mock.dart';
import 'Unit_tests/test_vue_club_list_mock.dart';
import 'Widgets/test_authentication_widget.dart';
import 'Widgets/test_vue_club_list_widget.dart';

void main() {
  /*** Units Testing ***/

  // Test Authentication Requests with Unit tests
  authUnitTest();
  // Test List Club Requests with Unit tests
  listClubUnitTest();

  /*** Widgets Testing ***/

  // Test Authentication Widgets
  testAuthWidgets();
  // Test List Club Widgets
  testListClubWidget();
}
