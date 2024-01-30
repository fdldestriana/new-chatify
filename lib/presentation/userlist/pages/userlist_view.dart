import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/presentation/auth/bloc/bloc/auth_bloc.dart';
import 'package:new_chatify/presentation/auth/pages/signin_view.dart';
import 'package:new_chatify/presentation/chat/pages/chat_rooms_view.dart';
import 'package:new_chatify/presentation/userlist/bloc/userlist_bloc.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserlistBloc>(context).add(UsersListLoadRequested());
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
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignoutRequested());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninView()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
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
      body: BlocBuilder<UserlistBloc, UserlistState>(builder: (context, state) {
        if (state is UserlistLoadingState || state is UserlistInitial) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF31C48D)),
          );
        }
        if (state is UserlistLoadFailedState) {
          return Center(
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
            ),
          );
        }
        state as UserlistLoadSucceedState;
        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoomsView(
                      user: UserAppEntity(
                        uid: state.users[index].uid,
                        email: state.users[index].email,
                      ),
                    ),
                  ),
                );
              },
              child: ListTile(
                leading:
                    const CircleAvatar(child: Icon(Icons.person_2_rounded)),
                title: Text(
                  state.users[index].email
                      .replaceAll("@", " ")
                      .replaceAll(".com", ""),
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
