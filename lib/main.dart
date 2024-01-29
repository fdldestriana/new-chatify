import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chatify/injection_container.dart';
import 'package:new_chatify/presentation-on-working/auth/bloc/bloc/auth_bloc.dart';
import 'package:new_chatify/presentation-on-working/auth/pages/signin_view.dart';
import 'package:new_chatify/presentation/bloc/chat/bloc/chat_bloc.dart';
import 'package:new_chatify/presentation/bloc/user/user_bloc.dart';
import 'package:new_chatify/firebase_options.dart';
import 'package:new_chatify/presentation/views/chat_room_list_view.dart';
import 'package:new_chatify/core/utils/state_util.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => ChatBloc()),
        BlocProvider(create: (_) => UserBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: (FirebaseAuth.instance.currentUser == null)
            ? const SigninView()
            : const ChatRoomListView(),
        navigatorKey: Get.navigatorKey,
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    log("USER ${FirebaseAuth.instance.currentUser!.email}");
    return Container(
      color: Colors.pinkAccent,
      child: Center(
        child: Text("${FirebaseAuth.instance.currentUser!.email}"),
      ),
    );
  }
}
