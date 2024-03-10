import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function pressed;
  final String label;
  const PrimaryButton({super.key, required this.pressed, required this.label});

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
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
