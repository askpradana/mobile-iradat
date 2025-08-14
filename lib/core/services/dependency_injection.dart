import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/quiz_local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/quiz_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_auth_status_usecase.dart';
import '../../domain/usecases/get_quizzes_usecase.dart';

class DependencyInjection {
  static Future<void> init() async {
    await _initCore();
    await _initDataSources();
    await _initRepositories();
    await _initUseCases();
    await _initControllers();
  }

  static Future<void> _initCore() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences, permanent: true);
    Get.put<http.Client>(http.Client(), permanent: true);
  }

  static Future<void> _initDataSources() async {
    Get.put<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(Get.find<SharedPreferences>()),
      permanent: true,
    );

    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(Get.find<http.Client>()),
      permanent: true,
    );

    Get.put<QuizLocalDataSource>(QuizLocalDataSourceImpl(), permanent: true);
  }

  static Future<void> _initRepositories() async {
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        remoteDataSource: Get.find<AuthRemoteDataSource>(),
        localDataSource: Get.find<AuthLocalDataSource>(),
      ),
      permanent: true,
    );

    Get.put<QuizRepository>(
      QuizRepositoryImpl(localDataSource: Get.find<QuizLocalDataSource>()),
      permanent: true,
    );
  }

  static Future<void> _initUseCases() async {
    Get.put<LoginUseCase>(
      LoginUseCase(Get.find<AuthRepository>()),
      permanent: true,
    );

    Get.put<LogoutUseCase>(
      LogoutUseCase(Get.find<AuthRepository>()),
      permanent: true,
    );

    Get.put<GetAuthStatusUseCase>(
      GetAuthStatusUseCase(Get.find<AuthRepository>()),
      permanent: true,
    );

    Get.put<GetQuizzesUseCase>(
      GetQuizzesUseCase(Get.find<QuizRepository>()),
      permanent: true,
    );
  }

  static Future<void> _initControllers() async {
    // Controllers will be initialized with bindings when needed
  }
}
