import 'package:flutter/material.dart';
import 'package:new_chatify/utils/state_util.dart';

class ReLoadingWidget extends StatelessWidget {
  const ReLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Get.width * 0.04),
          border: Border.all(
            color: const Color(0xFFDCD6D6),
          ),
        ),
        width: Get.width * 0.40,
        height: Get.height * 0.17,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF31C48D),
          ),
        ),
      ),
    ]);
  }
}
