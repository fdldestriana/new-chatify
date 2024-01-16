import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReButtonWidget extends StatelessWidget {
  const ReButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    required this.width,
    required this.height,
  });

  final String title;
  final void Function()? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF31C48D),
        minimumSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.poppins(
            color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
