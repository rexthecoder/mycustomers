import 'package:get_it/get_it.dart';
import 'package:mycustomers/core/services/page_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingletonAsync<IStorageUtil>(() => SharedStorageUtil.getInstance());
  locator.registerLazySingleton(() => PageService());


  
}