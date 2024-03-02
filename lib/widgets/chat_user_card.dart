import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:we_chat/api/apis.dart';
import 'package:we_chat/helper/my_date_util.dart';

import '../main.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  // last message info (if null --> show no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .03, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color.fromRGBO(255, 254, 229, 1),
      elevation: 1,
      child: InkWell(
          borderRadius: BorderRadius.circular(15),

          // for navigating to chat screen
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user)));
          },
          child: StreamBuilder(
              stream: APIs.getLastMessages(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                if (list.isNotEmpty) {
                  _message = list[0];
                }

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .025),
                    child: CachedNetworkImage(
                      width: mq.height * .05,
                      height: mq.height * .05,
                      imageUrl: widget.user.image,
                      // placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                  title: Text(widget.user.name),
                  subtitle: Text(
                      _message != null ? _message!.msg : widget.user.about,
                      maxLines: 1),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: _message != null &&
                            _message!.read.isEmpty &&
                            _message!.fromId != APIs.user.uid
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                        child: const Icon(CupertinoIcons.info),
                      ),
                      _message == null
                          ? const SizedBox()
                          : _message!.read.isEmpty &&
                                  _message!.fromId != APIs.user.uid
                              ? const Icon(Icons.circle,
                                  color: Colors.green, size: 10)
                              : Text(
                                  MyDateUtil.getLastMessageTime(
                                      context: context, time: _message!.sent),
                                  style: const TextStyle(color: Colors.black54),
                                )
                    ],
                  ),
                );
              })),
    );
  }
}
