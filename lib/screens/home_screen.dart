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
  // for storing all users
  List<ChatUser> _list = [];

  //for storing searched items
  final List<ChatUser> _searchList = [];

  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard when a tap is detected on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name / Email',
                    ),
                    autofocus: true,
                    style: const TextStyle(fontSize: 17, letterSpacing: 1),

                    // when search text changes, update search list
                    onChanged: (val) {
                      // search logic
                      _searchList.clear();
                      for (var i in _list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          _searchList.add(i);
                        }
                        setState(() {
                          _searchList;
                        });
                      }
                    },
                  )
                : const Text('WeChat'),
            actions: [
              IconButton(
                icon: Icon(_isSearching
                    ? CupertinoIcons.clear_circled_solid
                    : CupertinoIcons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
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
                  _list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                          [];

                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          _isSearching ? _searchList.length : _list.length,
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                            user: _isSearching
                                ? _searchList[index]
                                : _list[index]);
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
        ),
      ),
    );
  }
}
