import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../main.dart';
import './auth/login_screen.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../models/chat_user.dart';

// profile screen -- to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Do you want to logout?',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () async {
                            // for showing progress dialog
                            Dialogs.showProgressBar(context);

                            // sign out from app
                            await APIs.auth.signOut().then((value) async {
                              await GoogleSignIn().signOut().then((value) {
                                // for hiding progress dialog
                                Navigator.pop(context);

                                // for moving to profile screen
                                Navigator.pop(context);

                                // for moving to home screen
                                Navigator.pop(context);

                                // for replacing home screen with login screen
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()));
                              });
                            });
                          },
                        ),
                        TextButton(
                            child: const Text('No'),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: Column(
          children: [
            SizedBox(width: mq.width, height: mq.height * .03),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .075),
                  child: CachedNetworkImage(
                    width: mq.height * .15,
                    height: mq.height * .15,
                    fit: BoxFit.fill,
                    imageUrl: widget.user.image,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 65,
                  child: MaterialButton(
                    onPressed: () {},
                    elevation: 1,
                    shape: const CircleBorder(),
                    color: Colors.lightBlue.shade50,
                    child: const Icon(Icons.edit, color: Colors.lightBlue),
                  ),
                ),
              ],
            ),
            SizedBox(height: mq.height * .02),
            Text(
              widget.user.email,
              style: const TextStyle(color: Colors.black54),
            ),
            SizedBox(height: mq.height * .05),
            TextFormField(
              initialValue: widget.user.name,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  CupertinoIcons.person,
                  color: Colors.lightBlue,
                ),
                labelText: 'Name',
                hintText: 'eg. Aman Sirmaur',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: mq.height * .02),
            TextFormField(
              initialValue: widget.user.about,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  CupertinoIcons.pencil_ellipsis_rectangle,
                  color: Colors.lightBlue,
                ),
                labelText: 'About',
                hintText: 'eg. Feeling Happy!',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: mq.height * .02),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.lightBlue.shade50,
                fixedSize: Size(mq.width * .35, mq.height * .05),
              ),
              icon: const Icon(Icons.edit_note_outlined),
              label: const Text('Update'),
              onPressed: () {},
            )
          ],
        ),
      ),
      // body: ,
    );
  }
}
