import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/main.dart';
import 'package:mockito/mockito.dart';
import 'package:mycustomers/core/services/permissions.dart';
import 'package:mycustomers/core/models/customer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('App should work', (tester) async {

    TestWidgetsFlutterBinding.ensureInitialized();
   
    setupLogger(test: true);


    //DI && IC
    SharedPreferences.setMockInitialValues({});
    await setupLocator(useMockContacts: true, test: true);
    
    //Mock
    await locator.allReady();
    IOwnerServices iOwnerServices = locator<IOwnerServices>();
    MockPermissions _permission =  locator<Permissions>();
    
    //Checking for contact service
    await tester.runAsync(() async {
      when(iOwnerServices.getPhoneContacts()).thenAnswer((realInvocation) => Future.value(List<Customer>.generate(5, (int) => Customer.random())));
      when(_permission.getContactsPermission()).thenAnswer((realInvocation) => Future.value(false));
      await tester.pumpWidget(App());
    });
    
    await tester.pumpWidget(App());
    
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  });
}