import 'package:flutter_test/flutter_test.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('App should work', (tester) async {
    setupLocator();
    await tester.pumpWidget(App());
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  });
}