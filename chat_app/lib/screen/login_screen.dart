import 'package:chat_app/screen/chatroom.dart';
import 'package:chat_app/screen/registration_screen.dart';
import 'package:chat_app/utilities/const.dart';
import 'package:chat_app/widgets/chatnow_button.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String emailAdd;
  late String password;
  late final FirebaseAuth _auth;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
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
                onChanged: (value) {
                  emailAdd = value;
                },
              ),
              ChatTextField(
                label: 'Password',
                iconData: Icons.lock,
                isObsured: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: PrimaryButton(
                    label: 'Chat now!',
                    pressed: () async {
                      late SnackBar snackBar;

                      //display loading screen
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final credential =
                            await _auth.signInWithEmailAndPassword(
                                email: emailAdd, password: password);

                        if (credential != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, ChatRoom.id);
                        }
                      } catch (e) {
                        snackBar = SnackBar(
                          content: Text(e.toString()),
                          duration: const Duration(seconds: 3),
                        );

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      //off loading screen
                      setState(() {
                        isLoading = false;
                      });
                    }),
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
      ),
    );
  }
}
