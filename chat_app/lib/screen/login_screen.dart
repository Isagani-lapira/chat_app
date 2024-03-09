import 'package:chat_app/utilities/const.dart';
import 'package:chat_app/widgets/chatnow_button.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: kLinearGradient(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero(
              tag: 'Chat_logo',
              child: ChatLogo(logoSize: 150.0),
            ),
            const Text(
              'Sign in',
              style: kTitleStyle,
              textAlign: TextAlign.center,
            ),
            const ChatTextField(
              label: 'Email address',
              iconData: Icons.person,
              isObsured: false,
            ),
            const ChatTextField(
              label: 'Password',
              iconData: Icons.lock,
              isObsured: true,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: ChatNowButton(pressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
