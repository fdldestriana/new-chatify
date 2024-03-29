import 'package:flutter/material.dart';
import 'package:new_chatify/core/utils/state_util.dart';

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
      "assets/logo.png",
      width: width ?? Get.width * 0.47,
      height: height ?? Get.height * 0.22,
    );
  }
}
