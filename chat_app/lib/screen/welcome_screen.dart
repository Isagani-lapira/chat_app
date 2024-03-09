import 'dart:async';

import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/utilities/const.dart';
import 'package:chat_app/widgets/chatnow_button.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  late Future<void> _future;
  late bool _isButtonVisible = false;
  @override
  void initState() {
    super.initState();

    _future = loadAnimation();
    animationBackground();
  }

  Future<void> loadAnimation() async {
    await Future.delayed(const Duration(seconds: 6));
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

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isButtonVisible = true;
        }); //show button
      }
    });
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
                  child: FutureBuilder(
                    future: _future,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const RiveAnimation.asset(
                            'assets/animated_chatbot.riv');
                      }
                      return const Hero(
                        tag: 'Chat_logo',
                        child: ChatLogo(logoSize: 250),
                      );
                    }),
                  ),
                ),
                DefaultTextStyle(
                  style: kTitleStyle,
                  textAlign: TextAlign.center,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ScaleAnimatedText('CHAT ROOM!'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _isButtonVisible,
              child: ChatNowButton(
                pressed: () => Navigator.pushNamed(context, LoginScreen.id),
              ),
            )
          ],
        ),
      ),
    );
  }
}
