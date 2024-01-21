import 'package:flutter/material.dart';
import 'package:new_chatify/data/model/user_app.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key, required this.user});
  final UserApp user;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String interlocutor =
        widget.user.email.replaceAll("@", " ").replaceAll(".com", "");
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 47,
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
                          icon: const Icon(Icons.attach_file,
                              color: Color(0xFF231F20)),
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
                    onLongPress:
                        (messageController.text.isEmpty) ? () {} : () {},
                    onTap: (messageController.text.isEmpty) ? () {} : () {},
                    child: (messageController.text.isEmpty)
                        ? const Icon(
                            Icons.keyboard_voice,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
