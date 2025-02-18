import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_form_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  klogo,
                  height: 150,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Schat',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Pacifico',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnakkBar(
                              context, 'User Not Found Try To Register');
                        } else if (e.code == 'wrong-password') {
                          showSnakkBar(context,
                              'Wrong Password Try To Remember Your Password');
                        }
                      } catch (e) {
                        showSnakkBar(context, e.toString());
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t Have Account',
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        '  Register',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
