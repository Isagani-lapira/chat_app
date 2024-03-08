import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/utilities/const.dart';
import 'package:chat_app/widgets/chatnow_button.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    //hide the bottom navigation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: const BoxDecoration(gradient: kLinearGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Hero(
                  tag: 'Chat_logo',
                  child: ChatLogo(logoSize: 350),
                ),
                Text(
                  'ChatRoom!',
                  style: kTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            ChatNowButton(
              pressed: () => Navigator.pushNamed(context, LoginScreen.id),
            )
          ],
        ),
      ),
    );
  }
}
