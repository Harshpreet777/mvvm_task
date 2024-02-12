import 'package:get_it/get_it.dart';
import 'package:mvvm_task_demo/core/repos/services.dart';
import 'package:mvvm_task_demo/core/viewmodels/detail_view_model.dart';
import 'package:mvvm_task_demo/core/viewmodels/home_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Repository
  locator.registerLazySingleton(() => ApiServices());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => DetailViewModel());
}
