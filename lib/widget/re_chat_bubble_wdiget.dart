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
      width: 30,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: (message.receiverId != FirebaseAuth.instance.currentUser!.uid)
            ? const Color(0xFFDDFFEC)
            : const Color(0xFFF0F4F9),
      ),
      alignment: (message.receiverId != FirebaseAuth.instance.currentUser!.uid)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                message.message,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formatedTime,
                style:
                    TextStyle(color: const Color(0xFF000000).withOpacity(0.67)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
