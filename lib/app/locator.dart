import 'package:get_it/get_it.dart';
import 'package:mycustomers/app/services/page_service.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => PageService());
}