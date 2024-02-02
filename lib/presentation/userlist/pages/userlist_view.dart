import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_chatify/domain/shared/entities/message_entity.dart';
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
    BlocProvider.of<UserlistBloc>(context).add(UsersListItemLoadRequested());
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
        if (state is UserlistItemLoadingState || state is UserlistInitial) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF31C48D)),
          );
        }
        if (state is UserlistItemLoadFailedState) {
          return Center(
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
            ),
          );
        }
        state as UserlistItemLoadSucceedState;
        return ListView.builder(
          itemCount: state.userlistItemEntity.userListItem.length,
          itemBuilder: (BuildContext context, int index) {
            log("USERS, ${state.userlistItemEntity.userListItem.length}");
            log("USERS, ${state.userlistItemEntity.userListItem.length}");
            UserAppEntity user =
                state.userlistItemEntity.userListItem[index]["user"];
            MessageEntity messageEntity =
                state.userlistItemEntity.userListItem[index]["latestMessage"];
            String time =
                DateFormat("hh:mm").format(messageEntity.timestamp.toDate());
            String message = messageEntity.message.toString();

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoomsView(
                      user: UserAppEntity(
                        uid: user.uid,
                        email: user.email,
                      ),
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person_2_rounded),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.email
                              .replaceAll("@", " ")
                              .replaceAll(".com", ""),
                          style: GoogleFonts.roboto(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          time,
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Text(
                      message,
                      style: GoogleFonts.roboto(
                          fontSize: 17, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
