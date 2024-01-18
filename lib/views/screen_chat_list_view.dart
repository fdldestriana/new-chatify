import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chatify/bloc/user_bloc.dart';

class ScreenChatListView extends StatefulWidget {
  const ScreenChatListView({super.key});

  @override
  State<ScreenChatListView> createState() => _ScreenChatListViewState();
}

class _ScreenChatListViewState extends State<ScreenChatListView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UsersLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <IconButton>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 26.0,
            ),
          )
        ],
        title: Text(
          "Chatify",
          style: GoogleFonts.poppins(
              color: const Color(0xFF000000),
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF31C48D)),
            );
          } else if (state is UserLoadSuccedState) {
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    state.users[index].email,
                    style: GoogleFonts.poppins(fontSize: 18),
                  );
                },
              ),
            );
          }
          return Container(
            color: const Color(0xFF31C48D),
          );
        },
      ),
    );
  }
}
