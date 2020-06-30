import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mycustomers/core/models/business_card_model.dart';
import 'package:mycustomers/core/services/business_card_service.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/page_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

final GetIt locator = GetIt.instance;

const bool USE_MOCK_CUSTOMER = true;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingletonAsync<IStorageUtil>(() => SharedStorageUtil.getInstance());
  locator.registerLazySingleton(() => PageService());
  locator.registerLazySingleton<ICustomerService>(() => USE_MOCK_CUSTOMER ? MockCustomerService() : CustomerService());
  locator.registerLazySingleton<IBusinessCardService>(() => BusinessCardService());

  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter(BusinessCardAdapter());
}