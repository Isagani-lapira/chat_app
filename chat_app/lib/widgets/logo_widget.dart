import 'package:chat_app/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ChatLogo extends StatelessWidget {
  final double logoSize;
  const ChatLogo({super.key, required this.logoSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: logoSize,
            child: const RiveAnimation.asset(
              'assets/animated_chatbot.riv',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'ChatRoom!',
            style: kTitleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
