import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'features/device/domain/usecases/get_moisture_threshold.dart';
import 'features/device/domain/usecases/update_moisture_threshold.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/auth/data/datasources/remote_datasources.dart';
import 'features/auth/data/models/sign_in/sign_in_model.dart';
import 'features/auth/data/models/sign_up/sign_up_model.dart';
import 'features/auth/data/repositories/auth_repository_implementation.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_user_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/set_user_data_usecase.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'features/device/data/datasources/local_datasources.dart';
import 'features/device/data/datasources/remote_datasources.dart';
import 'features/device/data/models/device/device_model.dart';
import 'features/device/data/repositories/device_repository_implementation.dart';
import 'features/device/domain/entities/soil_measurement/soil_measurement.dart';
import 'features/device/domain/repositories/device_repository.dart';
import 'features/device/domain/usecases/get_device.dart';
import 'features/device/domain/usecases/save_user_device_id.dart';
import 'features/device/presentation/bloc/device/device_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  Hive.registerAdapter(SignInModelAdapter());
  Hive.registerAdapter(SignUpModelAdapter());
  Hive.registerAdapter(SoilMeasurementAdapter());
  Hive.registerAdapter(DeviceModelAdapter());

  var deviceBox = await Hive.openBox<DeviceModel>('device_box');

  sl.registerLazySingleton<Box<DeviceModel>>(
    () => deviceBox,
    instanceName: 'deviceBox',
  );

  // CORE Firebase Auth
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

  sl.registerFactory<DeviceBloc>(
    () => DeviceBloc(
      getDevice: sl<GetDeviceUseCase>(),
      saveUserDeviceIdUseCase: sl<SaveUserDeviceIdUseCase>(),
      getMoistureThreshold: sl<GetMoistureThresholdUseCases>(),
      updateMoistureThresholdUseCase: sl<UpdateMoistureThresholdUseCases>(),
      user: sl<FirebaseAuth>().currentUser,
    ),
  );

  // USE CASE
  //Auth
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(sl()),
  );

  sl.registerLazySingleton<GetUser>(
    () => GetUser(
      sl(),
    ),
  );

  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton<LogOutUseCase>(
    () => LogOutUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton<SetUserDataUseCase>(
    () => SetUserDataUseCase(
      sl(),
    ),
  );

  //Device
  sl.registerLazySingleton<SaveUserDeviceIdUseCase>(
    () => SaveUserDeviceIdUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton<GetDeviceUseCase>(
    () => GetDeviceUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<GetMoistureThresholdUseCases>(
    () => GetMoistureThresholdUseCases(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<UpdateMoistureThresholdUseCases>(
    () => UpdateMoistureThresholdUseCases(repository: sl()),
  );

  // REPOSITORY
  //Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(
      remoteDataSource: sl(),
    ),
  );

  //Device
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
