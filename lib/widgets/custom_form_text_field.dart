import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {this.onChanged, this.hintText, this.obscureText = false});

  String? hintText;
  Function(String)? onChanged;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'This Field is Required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
