import 'package:flutter/material.dart';

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
