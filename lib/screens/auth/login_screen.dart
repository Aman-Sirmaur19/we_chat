import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../../helper/dialogs.dart';
import '../../api/apis.dart';

import '../home_screen.dart';

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

  _handleGoogleButtonClick() {
    // for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) {
      // for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (error) {
      log('\n_signInWithGoogle: $error');
      Dialogs.showSnackBar(context, 'Something went wrong! (Check internet)');
      return null;
    }
  }

  // sign out function
  // _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signOut();
  // }

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
          AnimatedPositioned(
            left: mq.width * .15,
            width: mq.width * .7,
            height: mq.height * .07,
            duration: const Duration(seconds: 1),
            bottom: _isAnimate ? mq.height * .15 : -mq.height * .07,
            child: ElevatedButton.icon(
              onPressed: () {
                _handleGoogleButtonClick();
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
