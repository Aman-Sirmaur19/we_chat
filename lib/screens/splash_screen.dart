import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

import './auth/login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if (FirebaseAuth.instance.currentUser != null) {
        log('\nUser: ${FirebaseAuth.instance.currentUser}');
        // navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        // navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // initializing mediaQuery for getting device screen size
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .01,
            right: mq.width * .05,
            width: mq.width * .5,
            child: Image.asset('assets/images/clouds.png'),
          ),
          Positioned(
            top: mq.height * .1,
            left: mq.width * .05,
            width: mq.width * .5,
            child: Image.asset('assets/images/clouds.png'),
          ),
          Positioned(
            top: mq.height * .28,
            right: mq.width * .05,
            width: mq.width * .5,
            child: Image.asset('assets/images/clouds.png'),
          ),
          Positioned(
            top: mq.height * .37,
            left: mq.width * .05,
            width: mq.width * .5,
            child: Image.asset('assets/images/clouds.png'),
          ),
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/images/dove.png'),
          ),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                ),
                children: [
                  TextSpan(
                    text: 'MADE WITH ',
                    style: TextStyle(color: Colors.black45),
                  ),
                  TextSpan(text: '❤️'),
                  TextSpan(
                    text: ' IN ',
                    style: TextStyle(color: Colors.black45),
                  ),
                  TextSpan(text: '🇮🇳'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
