import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_chatify/domain/shared/entities/message_entity.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/presentation/chat/bloc/chat_bloc.dart';
import 'package:new_chatify/presentation/chat/widgets/re_chat_bubble_wdiget.dart';
import 'package:new_chatify/presentation/chat/widgets/re_message_input_widget.dart';

class ChatRoomsView extends StatefulWidget {
  const ChatRoomsView({super.key, required this.user});
  final UserAppEntity user;

  @override
  State<ChatRoomsView> createState() => _ChatRoomsViewState();
}

class _ChatRoomsViewState extends State<ChatRoomsView> {
  TextEditingController messageController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String interlocutorFirstName;
  late String interlocutorLastName;
  late String docId;

  @override
  void initState() {
    super.initState();
    var userIds = [widget.user.uid, firebaseAuth.currentUser!.uid];
    userIds.sort();
    docId = userIds.join("_");
    List<String> fullName = widget.user.email.split("@");
    interlocutorFirstName = fullName[0];
    interlocutorLastName = fullName[1].split(".com")[0];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ChatBloc>().add(ChatGetMessagesStarted(docId: docId));
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF31C48D)),
        leadingWidth: 30,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://docs.flutter.dev/assets/images/dash/BigDashAndLittleDash.png",
                fit: BoxFit.fill,
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(width: 15),
            Text(
                "${toBeginningOfSentenceCase(interlocutorFirstName)} ${toBeginningOfSentenceCase(interlocutorLastName)}"),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatInitial) {
                  return Container();
                }
                if (state is ChatSendMessageSucceedState) {
                  return Container();
                }
                if (state is ChatLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1BE096),
                    ),
                  );
                }
                if (state is ChatFailedState) {
                  return Center(
                    child: Text(
                      "The error message : ${state.errorMessage}",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                if (state is ChatGetMessagesCompleteState) {
                  return Container();
                }
                state as ChatGetMessageSucceedState;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  shrinkWrap: true,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    List<MessageEntity> messages = state.messages.toList();
                    return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: (messages[index].receiverId ==
                                FirebaseAuth.instance.currentUser!.uid)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          ReChatBubbleWidget(messageEntity: messages[index])
                        ]);
                  },
                );
              },
            ),
          ),
          ReMessageInputWidget(
            messageController: messageController,
            docId: docId,
            receiverId: widget.user.uid,
            senderId: firebaseAuth.currentUser!.uid,
          ),
        ],
      ),
    );
  }
}
