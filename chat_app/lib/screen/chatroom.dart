import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom extends StatefulWidget {
  static const String id = "chatroom.screen";
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String message = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late var currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Room',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF04D2FF),
        actions: [
          IconButton(
            onPressed: () {
              // _auth.signOut();
              // Navigator.pop(context);
              getMessages();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF04D2FF), width: 2.0),
                        ),
                      ),
                      onChanged: (value) => {message = value}),
                ),
                IconButton(
                    onPressed: () => sendMessage(message),
                    icon: const Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      try {
        db.collection('messages').add(
          {
            'sender': currentUser.email,
            'text': message,
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void getMessages() async {
    await for (var collection in db.collection('messages').snapshots()) {
      for (var data in collection.docs) {
        print(data.data());
      }
    }
  }
}
