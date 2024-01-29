import 'package:get_it/get_it.dart';
import 'package:new_chatify/data-on-working/auth/datasources/auth_datasource.dart';
import 'package:new_chatify/data-on-working/auth/repositories/auth_repository_impl.dart';
import 'package:new_chatify/domain-on-working/auth/repositories/auth_repository.dart';
import 'package:new_chatify/domain-on-working/auth/usecases/signin_usecase.dart';
import 'package:new_chatify/domain-on-working/auth/usecases/signout_usecase.dart';
import 'package:new_chatify/domain-on-working/auth/usecases/signup_usecase.dart';
import 'package:new_chatify/presentation-on-working/auth/bloc/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc registration
  sl.registerFactory(
    () => AuthBloc(
      signUpUseCase: sl(),
      signInUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );

  // Usecases registration
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(authRepository: sl()));

  // Repositories registration
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: sl()));

  // Data sources registration
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
}
