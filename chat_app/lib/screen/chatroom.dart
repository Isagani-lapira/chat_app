import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class ChatRoom extends StatefulWidget {
  static const String id = "chatroom.screen";
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String message = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late var currentUser;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
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
              _auth.signOut();
              Navigator.pop(context);
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: StreamBuilder(
                  stream: db
                      .collection('messages')
                      .orderBy('timestamp')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CupertinoActivityIndicator();
                    }

                    final data = snapshot.data?.docs.reversed;
                    List<Widget> messages = [];
                    for (var message in data!) {
                      String sender = message['sender'];
                      String text = message['text'];

                      messages.add(MessageBubble(
                        sender: sender,
                        message: text,
                        isSender: currentUser.email == sender,
                      ));
                    }

                    return ListView(
                      reverse: true,
                      children: messages,
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                      controller: _controller,
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
                  onPressed: () {
                    sendMessage(message);
                    // reset textfield
                    _controller.clear();
                    message = '';
                  },
                  icon: const Icon(Icons.send),
                )
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
            'timestamp': DateTime.now(),
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.sender,
    required this.message,
    required this.isSender,
  });

  final String sender;
  final String message;
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 25.0,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 5.0),
          Material(
            color: isSender
                ? Colors.blue
                : const Color.fromARGB(255, 202, 234, 235),
            elevation: 5.0,
            borderRadius: isSender
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0))
                : const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black54,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
