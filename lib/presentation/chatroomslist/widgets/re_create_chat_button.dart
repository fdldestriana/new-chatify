import 'package:flutter/material.dart';
import 'package:new_chatify/presentation/userlist/pages/userlist_view.dart';

class ReCreateChatButton extends StatelessWidget {
  const ReCreateChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserListView(),
          ),
        );
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
            color: Color(0xFF31C48D), shape: BoxShape.circle),
        child: Image.asset("assets/buttons/create_chat_logo.png"),
      ),
    );
  }
}
