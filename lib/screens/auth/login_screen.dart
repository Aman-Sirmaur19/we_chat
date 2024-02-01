import 'package:flutter/material.dart';
import 'package:we_chat/screens/home_screen.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to WeChat!'),
      ),
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
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: const Duration(seconds: 1),
            child: Image.asset('assets/images/dove.png'),
          ),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .15,
            width: mq.width * .7,
            height: mq.height * .07,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              icon: Image.asset(
                'assets/images/google.png',
                height: mq.height * .03,
              ),
              label: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.lightBlue),
                  children: [
                    TextSpan(text: 'Login with '),
                    TextSpan(
                      text: 'Google',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen.shade100,
                shape: const StadiumBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
