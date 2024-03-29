import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../main.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../api/apis.dart';
import '../widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // for storing all messages
  List<Message> _list = [];

  // for handling message text changes
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back, color: Colors.black54),
            onPressed: () => Navigator.pop(context),
          ),
          title: InkWell(
            onTap: () {},
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .025),
                  child: CachedNetworkImage(
                    width: mq.height * .05,
                    height: mq.height * .05,
                    imageUrl: widget.user.image,
                    // placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Last seen',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(255, 254, 229, 1),
        body: SizedBox(
          height: mq.height * .85,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: APIs.getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      // if data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                      // return const SizedBox();

                      // if data is loaded then show it
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        _list = data
                                ?.map((e) => Message.fromJson(e.data()))
                                .toList() ??
                            [];
                        if (_list.isNotEmpty) {
                          return ListView.builder(
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemCount: _list.length,
                            itemBuilder: (context, index) {
                              return MessageCard(message: _list[index]);
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Say Hi! 👋',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.68),
                              ),
                            ),
                          );
                        }
                    }
                  },
                ),
              ),
              _chatInput(),
            ],
          ),
        ),
      ),
    );
  }

  // bottom chat text input field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .02),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // emoji button
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Send message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.image,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text);
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding: const EdgeInsets.only(
              right: 5,
              left: 10,
              top: 10,
              bottom: 10,
            ),
            shape: const CircleBorder(),
            color: Colors.green[300],
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
