import 'package:flutter/material.dart';
import 'package:new_chatify/state_util.dart';

class ReTextFormFieldWidget extends StatelessWidget {
  const ReTextFormFieldWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        // to change the color, set filled to true and set the color in fillColor
        filled: true,
        fillColor: const Color(0xFFFEFEFE),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
                style: BorderStyle.none, color: Color(0xFFFEFEFE), width: 0),
            borderRadius: BorderRadius.circular(Get.width * 0.06)),
        prefixIcon: const Icon(Icons.phone),
        prefixIconColor: const Color(0xFF000000),
        contentPadding: EdgeInsets.only(
            left: Get.width * 0.08,
            top: Get.height * 0.01,
            bottom: Get.height * 0.01),
        labelText: "Phone Number",
      ),
    );
  }
}
