import 'package:flutter/material.dart';
import 'package:new_chatify/data/model/user_app.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key, required this.user});
  final UserApp user;

  @override
  Widget build(BuildContext context) {
    String interlocutor =
        user.email.replaceAll("@", " ").replaceAll(".com", "");
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
    );
  }
}
