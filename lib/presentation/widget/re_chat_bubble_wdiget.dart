import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_chatify/data/model/message.dart';

class ReChatBubbleWidget extends StatelessWidget {
  const ReChatBubbleWidget({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(DateTime.fromMillisecondsSinceEpoch(
      message.timestamp.microsecondsSinceEpoch,
    ).toString());
    String formatedTime = DateFormat("hh:mm").format(time);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: (message.receiverId != FirebaseAuth.instance.currentUser!.uid)
            ? const Color(0xFFDDFFEC)
            : const Color(0xFFF0F4F9),
      ),
      alignment: (message.receiverId == FirebaseAuth.instance.currentUser!.uid)
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            (message.receiverId == FirebaseAuth.instance.currentUser!.uid)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
        children: [
          Text(message.message,
              style: const TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible)),
          Text(
            formatedTime,
            style: TextStyle(
              color: const Color(0xFF000000).withOpacity(0.67),
            ),
          )
        ],
      ),
    );
  }
}
