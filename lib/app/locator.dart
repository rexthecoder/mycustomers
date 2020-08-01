import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mycustomers/core/data_sources/business_card/business_card_local_data_source.dart';
import 'package:mycustomers/core/data_sources/complaint/complaint_local.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/data_sources/stores/stores_local_data_source.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/market_message/message_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/models/hive/password_manager/password_manager_model_h.dart';
import 'package:mycustomers/core/repositories/business_card/business_card_repository.dart';
import 'package:mycustomers/core/repositories/business_card/business_card_repository_impl.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/auth/auth_service_impl.dart';
import 'package:mycustomers/core/services/business_card/business_card_service.dart';
import 'package:mycustomers/core/services/business_card/business_card_service_impl.dart';
import 'package:mycustomers/core/services/message_service.dart';
import 'package:mycustomers/core/services/notifications/notifications_service.dart';
import 'package:mycustomers/core/services/notifications/notifications_service_impl.dart';
import 'package:mycustomers/core/services/phone_contact_service.dart';
import 'package:mycustomers/core/services/profile_service.dart';
import 'package:hive/hive.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/connectivity/connectivity_service_impl.dart';
import 'package:mycustomers/core/services/connectivity/connectivity_services.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/services/http/http_service_impl.dart';
import 'package:mycustomers/core/services/localStorage_services.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:mycustomers/core/services/api_services.dart';
import 'package:mycustomers/core/services/page_service.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:mycustomers/core/utils/file_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mycustomers/core/services/user_services.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:mycustomers/core/data_sources/stores/stores_remote_data_source.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:mycustomers/core/models/hive/store/store_h.dart';
import 'package:mycustomers/core/models/hive/complaint/complaint_h.dart';
import 'package:mycustomers/core/enums/connectivity_status.dart';

final GetIt locator = GetIt.instance;

const bool USE_MOCK_CUSTOMER = true;

String isoCode = 'NG';

Future<void> setIso() async {
  try {
    isoCode = (await FlutterSimCountryCode.simCountryCode) ?? isoCode;
  } on PlatformException {}
}

/// Setup function that is run before the App is run.
/// Arrange in order of most wanted service on start
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator(
    {bool useMockContacts: false,
    bool useMockCustomer: true,
    bool test = false}) async {
  //Inizialize Hive path
  Directory appDocDir =
      test ? Directory.current : await getApplicationDocumentsDirectory();
  test ? Hive.init(appDocDir.path) : Hive.initFlutter(appDocDir.path);

  /// Services
  locator.registerLazySingleton(
    () => NavigationService(),
  );
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<DialogService>(
    () => DialogService(),
  );
  locator.registerLazySingleton<IApi>(
    () => ApiServices(),
  );
  locator.registerLazySingleton(
    () => PageService(),
  );
  locator.registerLazySingleton<ICustomerService>(
    () => USE_MOCK_CUSTOMER ? MockCustomerService() : CustomerService(),
  );
  locator.registerLazySingleton<PasswordManagerService>(
    () => PasswordManagerService(),
  );
  locator.registerLazySingleton<BussinessSettingService>(
    () => BussinessSettingService(),
  );
  locator.registerLazySingleton<ProfileService>(
    () => ProfileService(),
  );
  await _setupSharedPreferences();
  locator.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(),
  );
  locator.registerLazySingleton<HttpService>(
    () => HttpServiceImpl(),
  );
  locator.registerLazySingleton<IOwnerServices>(
    () => useMockContacts ? MockOwnerService() : OwnerServices(),
  );
  locator.registerLazySingleton<UserService>(
    () => UserService(),
  );
  locator.registerLazySingleton<BusinessCardService>(
    () => BusinessCardServiceImpl(businessCardRepository: locator()),
  );

  // Local notification service
  locator.registerLazySingleton<NotificationRemindersService>(
    () => NotificationRemindersServiceImpl(),
  );

  // Repository
  locator.registerLazySingleton<BusinessCardRepository>(
    () => BusinessCardRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<StoreRepository>(
    () => StoreRepository(),
  );

  // Data sources
  locator.registerLazySingleton<StoreDataSourceImpl>(
    () => StoreDataSourceImpl(),
  );

  if (test)
    locator.registerLazySingleton<StoresLocalDataSource>(
      () => StoresLocalDataSourceImpl()..init(),
    );
  locator.registerLazySingleton<TransactionLocalDataSourceImpl>(
    () => TransactionLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<CustomerContactService>(
    () => CustomerContactService(),
  );
  locator.registerLazySingleton<LogsLocalDataSourceImpl>(
    () => LogsLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<BusinessCardLocalDataSource>(
    () => BusinessCardLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<ComplaintLocalDataSource>(
    () => ComplaintLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<MessageService>(
    () => MessageService(),
  );
  locator.registerLazySingleton<PhoneContactService>(
    () => PhoneContactService(),
  );
  // locator.registerLazySingleton<LocalStorageService>(
  //   () => LocalStorageService(),
  // );

  var instance = await LocalStorageService.getInstance();

  locator.registerSingleton<LocalStorageService>(instance);

  // Util
  locator.registerLazySingleton<FileHelper>(() => FileHelperImpl());
  locator.registerLazySingleton<IPermissionService>(
    () => useMockContacts ? MockPermissions() : PermissionService(),
  );

  // External
  if (!test) {
    locator.registerLazySingleton<HiveInterface>(() => Hive);
  }

  print('Initializing boxes...');
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(ComplaintAdapter());

  //Initialization for all boxes
  await BusinessCardLocalDataSourceImpl().init();
  await LogsLocalDataSourceImpl().init();
  //await TransactionLocalDataSourceImpl().init();
  await BussinessSettingService().init();
  await CustomerContactService().init();
  await ProfileService().init();
  await PhoneContactService().init();
  await locator<ComplaintLocalDataSource>().init();
  //await PhoneContactService().deleteAll();
  //await PhoneContactService().init();
  //await MessageService().init();

//  Hive.registerAdapter(BusinessCardAdapter());
  Hive.registerAdapter(PasswordManagerAdapter());
  //Hive.registerAdapter(CustomerContactAdapter());
  Hive.registerAdapter(StoreHAdapter());

  if (!test) {
    await setIso();
    await openBoxes();
    _registerConnListeners();
  }
}

Future<void> openBoxes() async {
  final _ss = StoresLocalDataSourceImpl();
  await _ss.init();
  locator.registerLazySingleton<StoresLocalDataSource>(
    () => _ss,
  );
}

Future<void> _setupSharedPreferences() async {
  final storage = await SharedStorageUtil.getInstance();
  locator.registerLazySingleton<IStorageUtil>(() => storage);
}

final List<Function(ConnectivityStatus)> connectivityListeners = [
  locator<ComplaintLocalDataSource>().syncComplaint,
];

void _registerConnListeners() {
  locator<ConnectivityService>()
      .registerAllListeners(connectivityListeners);
}
