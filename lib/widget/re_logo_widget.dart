import 'package:flutter/material.dart';
import 'package:new_chatify/state_util.dart';

class ReLogoWidget extends StatelessWidget {
  const ReLogoWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/launcher/chatify.png",
      width: width ?? Get.width * 0.47,
      height: height ?? Get.height * 0.22,
    );
  }
}
