import 'package:chat_app/screen/registration_screen.dart';
import 'package:chat_app/utilities/const.dart';
import 'package:chat_app/widgets/chatnow_button.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';

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
            const Text(
              'Sign in',
              style: kTitleStyle,
              textAlign: TextAlign.center,
            ),
            ChatTextField(
              label: 'Email address',
              iconData: Icons.person,
              isObsured: false,
              onChanged: (value) {},
            ),
            ChatTextField(
              label: 'Password',
              iconData: Icons.lock,
              isObsured: true,
              onChanged: (value) {},
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: PrimaryButton(label: 'Chat now!', pressed: () {}),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: const Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 150.0,
              child: Hero(
                tag: 'Chat_logo',
                child: ChatLogo(logoSize: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
