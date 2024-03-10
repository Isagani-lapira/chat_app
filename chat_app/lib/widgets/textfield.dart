import 'package:chat_app/utilities/const.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool? isObsured;
  final Function onChanged;
  const ChatTextField({
    super.key,
    required this.label,
    required this.iconData,
    required this.onChanged,
    this.isObsured,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        style: const TextStyle(fontSize: 12.0),
        obscureText: isObsured ?? false,
        decoration: kTextFieldStyle.copyWith(
          labelText: label,
          prefixIcon: Icon(iconData),
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
