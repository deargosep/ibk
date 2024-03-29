import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:siignores/features/auth/domain/usecases/activation_code.dart';
import 'package:siignores/features/auth/domain/usecases/delete_account.dart';
import 'package:siignores/features/auth/domain/usecases/reset_password.dart';
import 'package:siignores/features/auth/domain/usecases/send_code_reset_password.dart';
import 'package:siignores/features/auth/domain/usecases/set_password.dart';
import 'package:siignores/features/auth/domain/usecases/verify_code_reset_password.dart';
import 'package:siignores/features/chat/domain/usecases/get_chat.dart';
import 'package:siignores/features/chat/domain/usecases/get_chat_tabs.dart';
import 'package:siignores/features/chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import 'package:siignores/features/home/domain/usecases/get_calendar.dart';
import 'package:siignores/features/home/domain/usecases/get_notifications.dart';
import 'package:siignores/features/home/domain/usecases/get_offers.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/profile/domain/repositories/profile/profile_repository.dart';
import 'package:siignores/features/profile/domain/usecases/update_avatar.dart';
import 'package:siignores/features/profile/domain/usecases/update_user_info.dart';
import 'package:siignores/features/training/domain/usecases/get_courses.dart';
import 'package:siignores/features/training/domain/usecases/get_lesson.dart';
import 'package:siignores/features/training/domain/usecases/get_lessons.dart';
import 'package:siignores/features/training/domain/usecases/get_modules.dart';
import 'package:siignores/features/training/domain/usecases/get_test.dart';
import 'package:siignores/features/training/domain/usecases/send_homework.dart';
import 'package:siignores/features/training/presentation/bloc/lessons/lessons_bloc.dart';
import 'package:siignores/features/training/presentation/bloc/modules/module_bloc.dart';
import 'constants/main_config_app.dart';
import 'core/services/database/auth_params.dart';
import 'core/services/network/config.dart';
import 'core/services/network/network_info.dart';
import 'features/auth/data/datasources/auth/local_datasource.dart';
import 'features/auth/data/datasources/auth/remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth/auth_repository.dart';
import 'features/auth/domain/usecases/auth_signin.dart';
import 'features/auth/domain/usecases/get_token_local.dart';
import 'features/auth/domain/usecases/get_user_info.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'features/auth/presentation/bloc/register/register_bloc.dart';
import 'features/chat/data/datasources/chat/remote_datasource.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat/chat_repository.dart';
import 'features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'features/home/data/datasources/home/remote_datasource.dart';
import 'features/home/data/datasources/offers/remote_datasource.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/data/repositories/offers_repository_impl.dart';
import 'features/home/domain/repositories/home/home_repository.dart';
import 'features/home/domain/repositories/home/offers_repository.dart';
import 'features/home/domain/usecases/get_progress.dart';
import 'features/home/presentation/bloc/calendar/calendar_bloc.dart';
import 'features/home/presentation/bloc/notifications/notifications_bloc.dart';
import 'features/home/presentation/bloc/offers/offers_bloc.dart';
import 'features/home/presentation/bloc/progress/progress_bloc.dart';
import 'features/profile/data/datasources/profile/remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/training/data/datasources/test/remote_datasource.dart';
import 'features/training/data/datasources/training_main/remote_datasource.dart';
import 'features/training/data/repositories/test_repository_impl.dart';
import 'features/training/data/repositories/training_repository_impl.dart';
import 'features/training/domain/repositories/test/test_repository.dart';
import 'features/training/domain/repositories/training/training_repository.dart';
import 'features/training/domain/usecases/complete_test.dart';
import 'features/training/domain/usecases/send_answer_test.dart';
import 'features/training/presentation/bloc/course/course_bloc.dart';
import 'features/training/presentation/bloc/lesson_detail/lesson_detail_bloc.dart';
import 'features/training/presentation/bloc/test/test_bloc.dart';


final sl = GetIt.instance;

void setupInjections() {

  //Main config of system
  sl.registerLazySingleton<MainConfigApp>(() => MainConfigApp());


  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerFactory<Dio>(
    () => Dio(BaseOptions(
      baseUrl: Config.url.url
    )),
  );

  sl.registerFactory<MainScreenBloc>(
    () => MainScreenBloc(),
  );

  ///Authentication
  sl.registerLazySingleton<AuthConfig>(() => AuthConfig());
  // //Datasources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(),
  );

  // //Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl(), sl()),
  );

  // //UseCases
  sl.registerLazySingleton(() => AuthSignIn(sl()));
  sl.registerLazySingleton(() => ActivationCode(sl()));
  sl.registerLazySingleton(() => GetUserInfo(sl()));
  sl.registerLazySingleton(() => GetTokenLocal(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => SetPassword(sl()));
  sl.registerLazySingleton(() => DeleteAccount(sl()));

  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => VerifyCodeResetPassword(sl()));
  sl.registerLazySingleton(() => SendCodeResetPassword(sl()));

  //Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(sl(), sl(), sl()),
  );
  sl.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(sl(), sl(), sl()),
  );











  ///Profile
  // //Datasources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: sl()),
  );

  // //Repositories
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl(), ),
  );

  // //UseCases
  sl.registerLazySingleton(() => UpdateAvatar(sl()));
  sl.registerLazySingleton(() => UpdateUserInfo(sl()));

  //Blocs
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(sl(), sl()),
  );














  ///Training
  // //Datasources
  sl.registerLazySingleton<TrainingRemoteDataSource>(
    () => TrainingRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<TestRemoteDataSource>(
    () => TestRemoteDataSourceImpl(dio: sl()),
  );

  // //Repositories
  sl.registerLazySingleton<TrainingRepository>(
    () => TrainingRepositoryImpl(sl(), sl(), ),
  );
  sl.registerLazySingleton<TestRepository>(
    () => TestRepositoryImpl(sl(), sl(), ),
  );

  // //UseCases
  sl.registerLazySingleton(() => GetCourses(sl()));
  sl.registerLazySingleton(() => GetModules(sl()));
  sl.registerLazySingleton(() => GetLessons(sl()));
  sl.registerLazySingleton(() => GetLesson(sl()));
  sl.registerLazySingleton(() => GetTest(sl()));
  sl.registerLazySingleton(() => SendAnswerTest(sl()));
  sl.registerLazySingleton(() => CompleteTest(sl()));
  sl.registerLazySingleton(() => SendHomework(sl()));

  //Blocs
  sl.registerFactory<CourseBloc>(
    () => CourseBloc(sl()),
  );
  sl.registerFactory<ModuleBloc>(
    () => ModuleBloc(sl()),
  );
  sl.registerFactory<LessonsBloc>(
    () => LessonsBloc(sl()),
  );
  sl.registerFactory<LessonDetailBloc>(
    () => LessonDetailBloc(sl(), sl()),
  );
  sl.registerFactory<TestBloc>(
    () => TestBloc(sl(), sl(), sl()),
  );










  ///Chat
  // //Datasources
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(dio: sl()),
  );

  // //Repositories
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(sl(), sl(), ),
  );

  // //UseCases
  sl.registerLazySingleton(() => GetChatTabs(sl()));
  sl.registerLazySingleton(() => GetChat(sl()));

  //Blocs
  sl.registerFactory<ChatTabsBloc>(
    () => ChatTabsBloc(sl()),
  );
  sl.registerFactory<ChatBloc>(
    () => ChatBloc(sl(),)
  );












  ///Home
  // //Datasources
  sl.registerLazySingleton<OffersRemoteDataSource>(
    () => OffersRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dio: sl()),
  );

  // //Repositories
  sl.registerLazySingleton<OffersRepository>(
    () => OffersRepositoryImpl(sl(), sl(), ),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl(), sl(), ),
  );

  // //UseCases
  sl.registerLazySingleton(() => GetOffers(sl()));
  sl.registerLazySingleton(() => GetCalendar(sl()));
  sl.registerLazySingleton(() => GetProgress(sl()));
  sl.registerLazySingleton(() => GetNotifications(sl()));

  //Blocs
  sl.registerFactory<OffersBloc>(
    () => OffersBloc(sl()),
  );
  sl.registerFactory<CalendarBloc>(
    () => CalendarBloc(sl()),
  );
  sl.registerFactory<ProgressBloc>(
    () => ProgressBloc(sl()),
  );
  sl.registerFactory<NotificationsBloc>(
    () => NotificationsBloc(sl()),
  );
}
