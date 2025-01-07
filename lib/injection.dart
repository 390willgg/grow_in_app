import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:grow_in_app/features/auth/data/datasources/remote_datasources.dart';
import 'package:grow_in_app/features/auth/data/repositories/authentication_repository_implementation.dart';
import 'package:grow_in_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:grow_in_app/features/auth/domain/usecases/check_verification_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/first_page_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/google_auth_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:grow_in_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/verifiy_email_usecase.dart';
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

var locator = GetIt.instance;

Future<void> init() async {
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(SoilMeasurementAdapter());
  Hive.registerAdapter(DeviceModelAdapter());

  var profileBox = await Hive.openBox<ProfileModel>("profile_box");
  var deviceBox = await Hive.openBox<DeviceModel>('device_box');

  locator.registerLazySingleton(
    () => profileBox,
    instanceName: 'profileBox',
  );

  locator.registerLazySingleton<Box<DeviceModel>>(
    () => deviceBox,
    instanceName: 'deviceBox',
  );

  // HTTP
  locator.registerLazySingleton<http.Client>(
    () => http.Client(),
  );

  // FIREBASE
  locator.registerLazySingleton<DatabaseReference>(
    () => FirebaseDatabase.instance.ref(),
  );

  // BLOC
  //Auth
  locator.registerFactory(
    () => AuthBloc(
      signInUseCse: locator(),
      signUpUseCase: locator(),
      verifyEmailUseCase: locator(),
      firstPageUseCase: locator(),
      checkVerificationUseCase: locator(),
      logOutUseCase: locator(),
      googleAuthUseCase: locator(),
    ),
  );

  locator.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getAllUser: locator(),
      getUser: locator(),
    ),
  );

  locator.registerFactory<DeviceBloc>(
    () => DeviceBloc(
      getDevice: locator(),
    ),
  );

  // USE CASE
  //Auth
  locator.registerLazySingleton(() => SignInUseCase(locator()));
  locator.registerLazySingleton(() => SignUpUseCase(locator()));
  locator.registerLazySingleton(() => FirstPageUseCase(locator()));
  locator.registerLazySingleton(() => VerifyEmailUseCase(locator()));
  locator.registerLazySingleton(() => CheckVerificationUseCase(locator()));
  locator.registerLazySingleton(() => LogOutUseCase(locator()));
  locator.registerLazySingleton(() => GoogleAuthUseCase(locator()));

  //Profile
  locator.registerLazySingleton<GetAllUser>(
    () => GetAllUser(
      locator(),
    ),
  );

  locator.registerLazySingleton<GetUser>(
    () => GetUser(
      locator(),
    ),
  );

  //Device
  locator.registerLazySingleton<GetDevice>(
    () => GetDevice(
      repository: locator(),
    ),
  );

  // REPOSITORY
  //Auth
  locator.registerLazySingleton<AuthRepository>(
    () => AuthenticationRepositoryImplementation(
      remoteDataSource: locator(),
    ),
  );

  //Profile
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
      localDataSource: locator<ProfileLocalDataSource>(),
      remoteDataSource: locator<ProfileRemoteDataSource>(),
      box: locator<Box<ProfileModel>>(instanceName: 'profileBox'),
    ),
  );

  locator.registerLazySingleton<DeviceRepository>(
    () => DeviceRepositoryImplementation(
      remoteDataSource: locator<DeviceRemoteDataSource>(),
      localDataSource: locator<DeviceLocalDataSource>(),
      box: locator<Box<DeviceModel>>(instanceName: 'deviceBox'),
    ),
  );

  // DATA SOURCE
  //Auth
  locator.registerLazySingleton(() => AuthRemoteDataSourceImpl());

  //Profile
  locator.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImplementation(
      box: locator<Box<ProfileModel>>(instanceName: 'profileBox'),
    ),
  );
  locator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImplementation(
      client: locator(),
    ),
  );

  //Device
  locator.registerLazySingleton<DeviceLocalDataSource>(
    () => DeviceLocalDataSourceImplementation(
      box: locator<Box<DeviceModel>>(instanceName: 'deviceBox'),
    ),
  );

  locator.registerLazySingleton<DeviceRemoteDataSource>(
    () => DeviceRemoteDataSourceImplementation(
      ref: locator(),
    ),
  );
}
