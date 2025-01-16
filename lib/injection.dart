import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:grow_in_app/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'features/auth/data/datasources/remote_datasources.dart';
import 'features/auth/data/models/sign_in/sign_in_model.dart';
import 'features/auth/data/models/sign_up/sign_up_model.dart';
import 'features/auth/data/repositories/auth_repository_implementation.dart';
import 'features/auth/domain/entities/first_page/first_page.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/check_verification_usecase.dart';
import 'features/auth/domain/usecases/first_page_usecase.dart';
import 'features/auth/domain/usecases/get_user_usecase.dart';
import 'features/auth/domain/usecases/google_auth_usecase.dart';
import 'features/auth/domain/usecases/logout_test_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/set_user_data_usecase.dart';
import 'features/auth/domain/usecases/sign_in_test_usecase.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_test_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/domain/usecases/verifiy_email_usecase.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/device/data/datasources/local_datasources.dart';
import 'features/device/data/datasources/remote_datasources.dart';
import 'features/device/data/models/device/device_model.dart';
import 'features/device/data/repositories/device_repository_implementation.dart';
import 'features/device/domain/entities/soil_measurement/soil_measurement.dart';
import 'features/device/domain/repositories/device_repository.dart';
import 'features/device/domain/usecases/get_device.dart';
import 'features/device/presentation/bloc/device_bloc.dart';
import 'features/profile/data/datasources/local_datasources.dart';
import 'features/profile/data/datasources/remote_datasources.dart';
import 'features/profile/data/models/profile_model.dart';
import 'features/profile/data/repositories/profile_repository_implementation.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  Hive.registerAdapter(SignInModelAdapter());
  Hive.registerAdapter(SignUpModelAdapter());
  Hive.registerAdapter(FirstPageAdapter());
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(SoilMeasurementAdapter());
  Hive.registerAdapter(DeviceModelAdapter());

  var profileBox = await Hive.openBox<ProfileModel>("profile_box");
  var deviceBox = await Hive.openBox<DeviceModel>('device_box');

  sl.registerLazySingleton(
    () => profileBox,
    instanceName: 'profileBox',
  );

  sl.registerLazySingleton<Box<DeviceModel>>(
    () => deviceBox,
    instanceName: 'deviceBox',
  );

  // HTTP
  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );

  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  // FIREBASE
  sl.registerLazySingleton<DatabaseReference>(
    () => FirebaseDatabase.instance.ref(),
  );

  // BLOC
  //Auth
  sl.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      signUpTestUseCase: sl(),
      setUserDataUseCase: sl(),
      signInTestUseCase: sl(),
      logOutTestUseCase: sl(),
      getUser: sl(),
    ),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUseCse: sl(),
      signUpUseCase: sl(),
      verifyEmailUseCase: sl(),
      firstPageUseCase: sl(),
      checkVerificationUseCase: sl(),
      logOutUseCase: sl(),
      googleAuthUseCase: sl(),
    ),
  );

  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getAllUser: sl(),
      getUser: sl(),
    ),
  );

  sl.registerFactory<DeviceBloc>(
    () => DeviceBloc(
      getDevice: sl(),
    ),
  );

  // USE CASE
  //Auth
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(sl()),
  );
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl()),
  );
  sl.registerLazySingleton<FirstPageUseCase>(
    () => FirstPageUseCase(sl()),
  );
  sl.registerLazySingleton<VerifyEmailUseCase>(
    () => VerifyEmailUseCase(sl()),
  );
  sl.registerLazySingleton<CheckVerificationUseCase>(
    () => CheckVerificationUseCase(sl()),
  );
  sl.registerLazySingleton<LogOutUseCase>(
    () => LogOutUseCase(sl()),
  );
  sl.registerLazySingleton<GoogleAuthUseCase>(
    () => GoogleAuthUseCase(sl()),
  );

  sl.registerLazySingleton<SignInTestUseCase>(
    () => SignInTestUseCase(sl()),
  );

  sl.registerLazySingleton<GetUserTest>(
    () => GetUserTest(
      sl(),
    ),
  );

  sl.registerLazySingleton<SignUpTestUseCase>(
    () => SignUpTestUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton<LogOutTestUseCase>(
    () => LogOutTestUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton<SetUserDataUseCase>(
    () => SetUserDataUseCase(
      sl(),
    ),
  );

  //Profile
  sl.registerLazySingleton<GetAllUser>(
    () => GetAllUser(
      sl(),
    ),
  );

  sl.registerLazySingleton<GetUser>(
    () => GetUser(
      sl(),
    ),
  );

  //Device
  sl.registerLazySingleton<GetDevice>(
    () => GetDevice(
      repository: sl(),
    ),
  );

  // REPOSITORY
  //Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(
      remoteDataSource: sl(),
    ),
  );

  //Profile
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
      localDataSource: sl<ProfileLocalDataSource>(),
      remoteDataSource: sl<ProfileRemoteDataSource>(),
      box: sl<Box<ProfileModel>>(instanceName: 'profileBox'),
    ),
  );

  sl.registerLazySingleton<DeviceRepository>(
    () => DeviceRepositoryImplementation(
      remoteDataSource: sl<DeviceRemoteDataSource>(),
      localDataSource: sl<DeviceLocalDataSource>(),
      box: sl<Box<DeviceModel>>(instanceName: 'deviceBox'),
    ),
  );

  // DATA SOURCE
  //Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  //Profile
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImplementation(
      box: sl<Box<ProfileModel>>(instanceName: 'profileBox'),
    ),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImplementation(
      client: sl(),
    ),
  );

  //Device
  sl.registerLazySingleton<DeviceLocalDataSource>(
    () => DeviceLocalDataSourceImplementation(
      box: sl<Box<DeviceModel>>(instanceName: 'deviceBox'),
    ),
  );

  sl.registerLazySingleton<DeviceRemoteDataSource>(
    () => DeviceRemoteDataSourceImplementation(
      ref: sl(),
    ),
  );
}
