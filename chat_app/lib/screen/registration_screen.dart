import 'package:chat_app/widgets/chatnow_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../utilities/const.dart';
import '../widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String emailAddress;
  late String password;
  late FirebaseAuth _auth;
  late bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          decoration: BoxDecoration(gradient: kLinearGradient()),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Registration',
                  style: kTitleStyle,
                  textAlign: TextAlign.center,
                ),
                ChatTextField(
                  label: 'Email address',
                  iconData: Icons.person,
                  onChanged: (value) {
                    emailAddress = value;
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
                    label: 'Register',
                    pressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        // create account
                        UserCredential newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: emailAddress, password: password);

                        if (newUser != null) {
                          Navigator.pop(context);
                        } else {
                          print('ayaw parin');
                        }
                      } catch (e) {
                        print(e);
                      }

                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
