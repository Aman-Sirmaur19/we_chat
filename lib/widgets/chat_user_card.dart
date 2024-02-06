import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .03, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color.fromRGBO(255, 254, 229, 1),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: ListTile(
          leading: const CircleAvatar(child: Icon(CupertinoIcons.person)),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about, maxLines: 1),
          trailing:
              const Text('12:00 PM', style: TextStyle(color: Colors.black54)),
        ),
      ),
    );
  }
}
