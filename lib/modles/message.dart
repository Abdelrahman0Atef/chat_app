import 'package:chat_app/constants.dart';

class Message {
  final String message;

  Message(this.message);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage]);
  }
  //to use for user
  //factory Message.fromJson(Map<String, dynamic> jsonData) {
}
