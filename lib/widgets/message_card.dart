import 'package:flutter/material.dart';

import '../main.dart';
import '../models/message.dart';
import '../api/apis.dart';

// for showing single message details
class MessageCard extends StatefulWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late double _size;

  @override
  void initState() {
    super.initState();
    _size = widget.message.msg.length * .026;
    if (_size < .2) {
      _size = .2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  // sender or another user message
  Widget _blueMessage() {
    return Flexible(
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
                minWidth: widget.message.msg.length > 15
                    ? mq.width * .2
                    : mq.width * _size,
                maxWidth: widget.message.msg.length > 15
                    ? mq.width * .4
                    : mq.width * _size),
            padding: EdgeInsets.all(mq.width * .03),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .03, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(171, 204, 250, 100),
                border: Border.all(color: Colors.lightBlue),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.msg,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.message.sent} ',
                      style:
                          const TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mq.width * .03),
          child: Row(
            children: [
              Text(
                '${widget.message.sent} ',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
              const Icon(Icons.done_all_rounded, size: 15, color: Colors.blue),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .03),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .03, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(181, 250, 183, 100),
                border: Border.all(color: Colors.lightGreen),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
            child: Text(
              widget.message.msg,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
