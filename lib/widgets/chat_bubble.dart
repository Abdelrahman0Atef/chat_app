import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 24),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32)),
          color: kblue,
        ),
        child: Text(
          'all(8)all(8)all(8)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
