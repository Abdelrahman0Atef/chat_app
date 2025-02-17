import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

void showSnakkBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: kblue,
    ),
  );
}
