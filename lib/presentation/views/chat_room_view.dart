import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chatify/domain-on-working/shared/entities/user_entitiy.dart';
import 'package:new_chatify/presentation/bloc/chat/bloc/chat_bloc.dart';
import 'package:new_chatify/data/model/message.dart';
import 'package:new_chatify/presentation/widget/re_chat_bubble_wdiget.dart';
import 'package:new_chatify/presentation/widget/re_message_input_widget.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key, required this.user});
  final UserAppEntity user;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  TextEditingController messageController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String interlocutor;
  late String docId;

  @override
  void initState() {
    super.initState();
    var userIds = [widget.user.uid, firebaseAuth.currentUser!.uid];
    userIds.sort();
    docId = userIds.join("_");
    interlocutor = widget.user.email.replaceAll("@", " ");
    interlocutor = interlocutor.replaceAll(".com", "");
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
            const CircleAvatar(child: Icon(Icons.person_2_rounded)),
            const SizedBox(width: 15),
            Text(interlocutor),
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
                    List<Message> messages = state.messages.toList();
                    return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: (messages[index].receiverId ==
                                FirebaseAuth.instance.currentUser!.uid)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          ReChatBubbleWidget(message: messages[index])
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
