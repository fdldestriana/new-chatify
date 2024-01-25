import 'package:flutter/material.dart';
import 'package:new_chatify/utils/state_util.dart';

class ReTextFormFieldWidget extends StatelessWidget {
  const ReTextFormFieldWidget(
      {super.key, required this.controller, required this.labelText});

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: (labelText == "Email")
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFEFEFE),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
                style: BorderStyle.none, color: Color(0xFFFEFEFE), width: 0),
            borderRadius: BorderRadius.circular(Get.width * 0.06)),
        prefixIcon: (labelText == "Email")
            ? const Icon(Icons.email)
            : const Icon(Icons.password),
        prefixIconColor: const Color(0xFF000000),
        contentPadding: EdgeInsets.only(
            left: Get.width * 0.08,
            top: Get.height * 0.01,
            bottom: Get.height * 0.01),
        labelText: labelText,
      ),
      obscureText: (labelText == "Password") ? true : false,
    );
  }
}
