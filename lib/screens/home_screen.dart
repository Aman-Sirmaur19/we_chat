import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/chat_user_card.dart';
import '../api/apis.dart';
import '../models/chat_user.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        title: const Text('WeChat'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          PopupMenuButton(
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
            onSelected: (value) {
              if (value == 'My Profile') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: APIs.me)));
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'My Profile',
                  child: ListTile(
                      leading: Icon(CupertinoIcons.person),
                      title: Text('My Profile')),
                ),
                const PopupMenuItem(
                  value: 'Settings',
                  child: ListTile(
                    leading: Icon(CupertinoIcons.gear),
                    title: Text('Settings'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton.extended(
          icon: const Icon(CupertinoIcons.add),
          onPressed: () {},
          label: const Text('Add user'),
        ),
      ),
      body: StreamBuilder(
        stream: APIs.getAllUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            // if data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index]);
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No connections found!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.68),
                        ),
                      ),
                      SizedBox(height: mq.height * .05),
                      Image.asset(
                        'assets/images/waiting.png',
                        height: mq.height * .3,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
