import 'package:get_it/get_it.dart';
import 'package:new_chatify/data/auth/datasources/auth_datasource.dart';
import 'package:new_chatify/data/auth/repositories/auth_repository_impl.dart';
import 'package:new_chatify/data/chat/datasources/chat_datasource.dart';
import 'package:new_chatify/data/chat/repositories/chat_repository_impl.dart';
import 'package:new_chatify/data/userlist/datasources/userlist_datasource.dart';
import 'package:new_chatify/data/userlist/repositories/userlist_repository_impl.dart';
import 'package:new_chatify/domain/auth/repositories/auth_repository.dart';
import 'package:new_chatify/domain/auth/usecases/signin_usecase.dart';
import 'package:new_chatify/domain/auth/usecases/signout_usecase.dart';
import 'package:new_chatify/domain/auth/usecases/signup_usecase.dart';
import 'package:new_chatify/domain/chat/repositories/chat_repository.dart';
import 'package:new_chatify/domain/chat/usecases/get_message_usecase.dart';
import 'package:new_chatify/domain/chat/usecases/send_message_usecase.dart';
import 'package:new_chatify/domain/userlist/repositories/userlist_repository.dart';
import 'package:new_chatify/domain/userlist/usecases/userlist_usecase.dart';
import 'package:new_chatify/presentation/auth/bloc/bloc/auth_bloc.dart';
import 'package:new_chatify/presentation/chat/bloc/chat_bloc.dart';
import 'package:new_chatify/presentation/userlist/bloc/userlist_bloc.dart';

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

  sl.registerFactory(
    () => UserlistBloc(
      userListUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ChatBloc(
      sendMessageUseCase: sl(),
      getMessagesUseCase: sl(),
    ),
  );

  // Usecases registration
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(authRepository: sl()));

  sl.registerLazySingleton(() => UserListUseCase(userListRepository: sl()));

  sl.registerLazySingleton(() => SendMessageUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(chatRepository: sl()));

  // Repositories registration
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: sl()));

  sl.registerLazySingleton<UserListRepository>(
      () => UserListRepositoryImpl(userListDataSource: sl()));

  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(chatDataSource: sl()));

  // Data sources registration
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  sl.registerLazySingleton<UserListDataSource>(() => UserListDataSourceImpl());
  sl.registerLazySingleton<ChatDataSource>(() => ChatDataSourceImpl());
}
