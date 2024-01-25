import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReBottomTextAuthScreenWidget extends StatelessWidget {
  const ReBottomTextAuthScreenWidget({
    super.key,
    required this.text,
    required this.title,
    this.onTap,
  });
  final String text;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: text,
          style: GoogleFonts.poppins(
            color: const Color(0xFF000000),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: title,
              recognizer: TapGestureRecognizer()..onTap = onTap,
              style: GoogleFonts.poppins(
                color: const Color(0xFF31C48D),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
