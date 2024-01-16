import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chatify/bloc/auth_bloc.dart';

class ScreenChatListView extends StatelessWidget {
  const ScreenChatListView({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Text(email);
          },
        ),
      ),
    );
  }
}
