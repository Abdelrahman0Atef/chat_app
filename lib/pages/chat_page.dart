import 'package:chat_app/constants.dart';
import 'package:chat_app/modles/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List messageslist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageslist.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      klogo,
                      height: 50,
                    ),
                    const Text('Chat'),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageslist.length,
                      itemBuilder: (context, index) {
                        return messageslist[index].id == email
                            ? SChatBubble(
                                message: messageslist[index],
                              )
                            : ChatBubble(message: messageslist[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          kId: email
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: const Icon(
                          Icons.send_outlined,
                          color: kblue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kblue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kblue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kblue,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(body: Text('No Data Please Wait...'));
          }
        });
  }
}
