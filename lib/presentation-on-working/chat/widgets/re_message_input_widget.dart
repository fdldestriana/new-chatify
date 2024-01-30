import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chatify/domain-on-working/chat/entities/message_entity.dart';
import 'package:new_chatify/presentation-on-working/chat/bloc/chat_bloc.dart';

class ReMessageInputWidget extends StatelessWidget {
  const ReMessageInputWidget(
      {super.key,
      required this.messageController,
      required this.docId,
      required this.receiverId,
      required this.senderId});

  final TextEditingController messageController;
  final String docId;
  final String receiverId;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: const Color(0xFFC4C4C4),
                ),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Color(0xFF231F20),
                      ),
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                          hintText: "Type message ....",
                          hintStyle: TextStyle(color: Color(0xFF231F20)),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.attach_file, color: Color(0xFF231F20)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_camera,
                        color: Color(0xFF231F20)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
                color: Color(0xFF1BE096), shape: BoxShape.circle),
            child: InkWell(
              onTap: () {
                context.read<ChatBloc>().add(
                      ChatSendMessagesRequested(
                        docId: docId,
                        message: MessageEntity(
                          message: messageController.text.toString(),
                          receiverId: receiverId,
                          senderId: senderId,
                          timestamp: Timestamp.now(),
                        ),
                      ),
                    );
                messageController.clear();
              },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
