import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/screens/auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: const Text('WeChat'),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          child: Icon(CupertinoIcons.add),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ),
      ),
    );
  }
}
