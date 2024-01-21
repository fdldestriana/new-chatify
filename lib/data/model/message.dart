class Message {
  final String message;
  final String receiverId;
  final String senderId;
  final DateTime creationTime;

  Message(
      {required this.message,
      required this.receiverId,
      required this.senderId,
      required this.creationTime});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json["message"],
        receiverId: json["receiverId"],
        senderId: json["senderId"],
        creationTime: json["creationTime"]);
  }
}
