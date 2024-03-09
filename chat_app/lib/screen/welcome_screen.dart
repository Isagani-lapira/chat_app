import 'dart:async';

import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/utilities/const.dart';
import 'package:chat_app/widgets/chatnow_button.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late bool isBuildCompleted = false;
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    super.initState();

    animationBackground();
    //change the riv into image
    Timer(const Duration(seconds: 4), () {
      setState(() {
        isBuildCompleted = true;
      });
    });
  }

  void animationBackground() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInQuart,
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //hide the bottom navigation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          gradient: kLinearGradient(opacity: _animation.value),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 350,
                  child: (isBuildCompleted == false)
                      ? const RiveAnimation.asset('assets/animated_chatbot.riv')
                      : const Hero(
                          tag: 'Chat_logo',
                          child: ChatLogo(logoSize: 350.0),
                        ),
                ),
                const Text(
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
