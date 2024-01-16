import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chatify/state_util.dart';

class ReNotLoggedInWidget extends StatelessWidget {
  const ReNotLoggedInWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.09),
        SizedBox(
          width: Get.width * 0.74,
          height: Get.height * 0.04,
          child: Text(
            title,
            style: GoogleFonts.poppins(
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w700,
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: Get.height * 0.04)
      ],
    );
  }
}
