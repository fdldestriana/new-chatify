import 'package:get_it/get_it.dart';
import 'package:new_chatify/data-on-working/auth/datasources/auth_datasource.dart';
import 'package:new_chatify/data-on-working/auth/repositories/auth_repository_impl.dart';
import 'package:new_chatify/data-on-working/chat/datasources/chat_datasource.dart';
import 'package:new_chatify/data-on-working/chat/repositories/chat_repository_impl.dart';
import 'package:new_chatify/data-on-working/userlist/datasources/userlist_datasource.dart';
import 'package:new_chatify/data-on-working/userlist/repositories/userlist_repository_impl.dart';
import 'package:new_chatify/domain-on-working/auth/repositories/auth_repository.dart';
import 'package:new_chatify/domain-on-working/auth/usecases/signin_usecase.dart';
import 'package:new_chatify/domain-on-working/auth/usecases/signout_usecase.dart';
import 'package:new_chatify/domain-on-working/auth/usecases/signup_usecase.dart';
import 'package:new_chatify/domain-on-working/chat/repositories/chat_repository.dart';
import 'package:new_chatify/domain-on-working/chat/usecases/get_message_usecase.dart';
import 'package:new_chatify/domain-on-working/chat/usecases/send_message_usecase.dart';
import 'package:new_chatify/domain-on-working/userlist/repositories/userlist_repository.dart';
import 'package:new_chatify/domain-on-working/userlist/usecases/userlist_usecase.dart';
import 'package:new_chatify/presentation-on-working/auth/bloc/bloc/auth_bloc.dart';
import 'package:new_chatify/presentation-on-working/chat/bloc/chat_bloc.dart';
import 'package:new_chatify/presentation-on-working/userlist/bloc/userlist_bloc.dart';

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
