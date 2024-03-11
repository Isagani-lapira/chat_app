import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screen/chatroom.dart';
import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/screen/registration_screen.dart';
import 'package:chat_app/screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatRoom.id: (context) => const ChatRoom(),
      },
    );
  }
}
