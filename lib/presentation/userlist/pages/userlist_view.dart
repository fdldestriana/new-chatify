import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:new_chatify/presentation/userlist/widgets/re_create_chat_button.dart';

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
        body:
            BlocBuilder<UserlistBloc, UserListState>(builder: (context, state) {
          if (state is UserListLoadingState || state is UserListInitial) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF31C48D)),
            );
          }
          if (state is UserListLoadFailedState) {
            return Center(
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }
          state as UserListLoadSucceedState;
          return ListView.builder(
            itemCount: state.userList.length,
            itemBuilder: (BuildContext context, int index) {
              UserAppEntity user = state.userList[index];
              /*
            TODO: Find clever way to extract the user name
             */
              List<String> fullName = user.email.split("@");
              String firstName = fullName[0];
              String lastName = fullName[1].split(".com")[0];

              MessageEntity messageEntity = user.latestMessage;
              String message = (messageEntity.senderId ==
                          FirebaseAuth.instance.currentUser!.uid ||
                      messageEntity.receiverId ==
                          FirebaseAuth.instance.currentUser!.uid)
                  ? messageEntity.message
                  : "";

              String time =
                  DateFormat("hh:mm").format(messageEntity.timestamp.toDate());

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoomsView(
                        user: UserAppEntity(
                          uid: user.uid,
                          email: user.email,
                          latestMessage: user.latestMessage,
                        ),
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.network(
                    'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    fit: BoxFit.fill,
                    width: 75,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${toBeginningOfSentenceCase(firstName)} ${toBeginningOfSentenceCase(lastName)}",
                            style: GoogleFonts.roboto(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            messageEntity.message == "" ? "" : time,
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Text(
                        message,
                        style: GoogleFonts.roboto(
                            fontSize: 17, fontWeight: FontWeight.w200),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        floatingActionButton: const ReCreateChatButton());
  }
}
