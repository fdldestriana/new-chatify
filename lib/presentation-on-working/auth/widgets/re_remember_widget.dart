import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReRememberWidget extends StatefulWidget {
  const ReRememberWidget({
    super.key,
  });

  @override
  State<ReRememberWidget> createState() => _ReRememberWidgetState();
}

class _ReRememberWidgetState extends State<ReRememberWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: const Color(0xFF31C48D),
            value: isChecked,
            onChanged: (value) {
              isChecked = value!;
              setState(() {});
            }),
        Text(
          "Remember me",
          style: GoogleFonts.poppins(
            color: const Color(0xFF000000),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
