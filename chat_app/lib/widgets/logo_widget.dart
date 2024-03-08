import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ChatLogo extends StatelessWidget {
  final double logoSize;
  const ChatLogo({super.key, required this.logoSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: logoSize,
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
