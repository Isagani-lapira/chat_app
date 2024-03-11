import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  static const String id = "chatroom.screen";
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Isagani',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF04D2FF),
      ),
      body: Column(),
    );
  }
}
