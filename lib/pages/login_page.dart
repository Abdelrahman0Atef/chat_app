import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFCFCF7),
        body: Column(
          children: [
            Image.asset('assets/images/message.png'),
            const Text(
              'Schat',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Pacifico',
                color: Colors.black,
              ),
            )
          ],
        ));
  }
}
