import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/auth/data/datasources/authRemoteDataSource.dart';
import '../../features/auth/data/repositories/authRepositoryImpl.dart';
/// AUTH IMPORTS
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/getCurrentUser_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/tasks/data/datasources/task_remote_dataSource.dart';
/// TASK IMPORTS
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/task_use_case.dart';
import '../../features/tasks/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // =========================================================
  // 🔥 EXTERNAL DEPENDENCIES (Firebase)
  // =========================================================

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // =========================================================
  // 🔐 AUTH FEATURE
  // =========================================================

  /// Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(sl()),
  );

  /// Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  /// Bloc
  sl.registerFactory(
        () => AuthBloc(
      signUp: sl(),
      login: sl(),
      logout: sl(),
      getCurrentUser: sl(),
    ),
  );

  // =========================================================
  // 📌 TASK FEATURE
  // =========================================================

  /// Data Source
  sl.registerLazySingleton<TaskRemoteDataSource>(
        () => TaskRemoteDataSource(sl()),
  );

  /// Repository
  sl.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));

  /// Bloc
  sl.registerFactory(
        () => TaskBloc(
      getTasks: sl(),
      addTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
    ),
  );
}