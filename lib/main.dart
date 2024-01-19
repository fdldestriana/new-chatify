import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chatify/bloc/auth_bloc.dart';
import 'package:new_chatify/bloc/user_bloc.dart';
import 'package:new_chatify/firebase_options.dart';
import 'package:new_chatify/state_util.dart';
import 'package:new_chatify/views/screen_chat_list_view.dart';
import 'package:new_chatify/views/signin_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthBloc()),
        BlocProvider(create: (BuildContext context) => UserBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: (FirebaseAuth.instance.currentUser != null)
            ? const ScreenChatListView()
            : const SigninView(),
        navigatorKey: Get.navigatorKey,
      ),
    );
  }
}
