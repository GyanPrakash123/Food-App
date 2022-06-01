import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyBoardType;
  CustomTextField({this.controller, this.keyBoardType, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyBoardType,
      textInputAction: TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
