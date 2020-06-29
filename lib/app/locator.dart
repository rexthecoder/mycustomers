import 'package:get_it/get_it.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:mycustomers/core/services/page_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/services/permissions.dart';

final GetIt locator = GetIt.instance;

const bool USE_MOCK_CUSTOMER = true;

void setupLocator({bool useMockContacts: false, bool useMockCustomer: true}) {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingletonAsync<IStorageUtil>(() => SharedStorageUtil.getInstance());
  locator.registerLazySingleton(() => PageService());
  locator.registerLazySingleton<Permissions>(() => useMockContacts ? MockPermissions() :  Permissions());
  locator.registerLazySingleton<IOwnerServices>(() => useMockContacts ? MockOwnerService() : OwnerServices());
  locator.registerLazySingleton<ICustomerService>(() => USE_MOCK_CUSTOMER ? MockCustomerService() : CustomerService());

}