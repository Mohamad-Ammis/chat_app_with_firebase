import 'package:chatapp/Constans.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/message.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.msg});
  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.only(
          top: 28,
          left: 16,
          bottom: 28,
          right: 28,
        ),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(999),
                topRight: Radius.circular(999),
                bottomRight: Radius.circular(999))),
        child: Text(
          msg.messageText,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class ChatBubleFromFriend extends StatelessWidget {
  const ChatBubleFromFriend({super.key, required this.msg});
  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.only(
          top: 28,
          left: 28,
          bottom: 28,
          right: 16,
        ),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(999),
                topRight: Radius.circular(999),
                bottomLeft: Radius.circular(999))),
        child: Text(
          msg.messageText,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
