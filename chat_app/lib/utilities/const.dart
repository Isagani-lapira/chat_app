import 'package:flutter/material.dart';

LinearGradient kLinearGradient({double opacity = 1.0}) {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xFF04D2FF).withOpacity(opacity),
      const Color(0xFF55F2D6).withOpacity(opacity),
    ],
  );
}

const TextStyle kTitleStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 32.0,
  color: Colors.white,
);
