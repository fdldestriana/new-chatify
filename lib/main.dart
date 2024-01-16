import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_chatify/firebase_options.dart';
import 'package:new_chatify/state_util.dart';
import 'package:new_chatify/views/signup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignupView(),
      navigatorKey: Get.navigatorKey,
    );
  }
}