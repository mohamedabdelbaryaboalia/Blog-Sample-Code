import 'package:get_it/get_it.dart';
import 'package:homeward_interview_sample_code/services/storage/prefs.dart';
import 'package:homeward_interview_sample_code/services/web_api/blog_api.dart';
import 'package:homeward_interview_sample_code/services/web_api/login_api.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  serviceLocator.registerLazySingleton<Prefs>(() => Prefs());
  serviceLocator.registerLazySingleton<LoginApi>(() => LoginApi());
  serviceLocator.registerLazySingleton<BlogApi>(() => BlogApi());
}
