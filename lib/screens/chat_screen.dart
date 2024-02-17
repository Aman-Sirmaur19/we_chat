import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../main.dart';
import '../models/chat_user.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
