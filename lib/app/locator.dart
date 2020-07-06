import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/auth/auth_service_impl.dart';
import 'package:hive/hive.dart';
import 'package:mycustomers/core/models/business_card_model.dart';
import 'package:mycustomers/core/services/business_card_service.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/services/http/http_service_impl.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:mycustomers/core/services/page_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mycustomers/core/services/user_services.dart';
import 'package:mycustomers/core/services/store_services.dart';
import 'package:mycustomers/core/services/permissions.dart';

final GetIt locator = GetIt.instance;

const bool USE_MOCK_CUSTOMER = true;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator(
    {bool useMockContacts: false, bool useMockCustomer: true}) async {
  IStorageUtil _storage = await SharedStorageUtil.getInstance();
  // Services
  locator.registerLazySingleton(
    () => NavigationService(),
  );
  locator.registerLazySingleton<IStorageUtil>(
    () => _storage,
  );
  locator.registerLazySingleton(
    () => PageService(),
  );
  locator.registerLazySingleton<ICustomerService>(
    () => USE_MOCK_CUSTOMER ? MockCustomerService() : CustomerService(),
  );
  locator.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(),
  );
  locator.registerLazySingleton<HttpService>(
    () => HttpServiceImpl(),
  );
  locator.registerLazySingleton<Permissions>(
    () => useMockContacts ? MockPermissions() : Permissions(),
  );
  locator.registerLazySingleton<IOwnerServices>(
    () => useMockContacts ? MockOwnerService() : OwnerServices(),
  );
  locator.registerLazySingleton<IBusinessCardService>(
    () => BusinessCardService(),
  );
  locator.registerLazySingleton<UserService>(
    () => UserService(),
  );
  locator.registerLazySingleton<StoreService>(
    () => StoreService(),
  );

  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter(BusinessCardAdapter());
}
