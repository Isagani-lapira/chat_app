import 'package:flutter/material.dart';

class ChatNowButton extends StatelessWidget {
  final Function pressed;
  const ChatNowButton({super.key, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => pressed(),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        backgroundColor: const Color(0xFF5198F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: const Text(
        'Chat now!',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
