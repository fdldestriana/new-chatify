import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chatify/state_util.dart';
import 'package:new_chatify/widget/re_bottotextauthscreen_widget.dart';
import 'package:new_chatify/widget/re_button_widget.dart';
import 'package:new_chatify/widget/re_logo_widget.dart';
import 'package:new_chatify/widget/re_notloggedin_widget.dart';
import 'package:new_chatify/widget/re_remember_widget.dart';
import 'package:new_chatify/widget/re_textformfield_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.20),
            const ReLogoWidget(),
            const ReNotLoggedInWidget(title: "Sign up for free"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your email",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  ReTextFormFieldWidget(
                    controller: _emailController,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ReTextFormFieldWidget(
                    controller: _passwordController,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  const ReRememberWidget(),
                  SizedBox(height: Get.height * 0.03),
                  ReButtonWidget(
                    title: "Sign up",
                    width: Get.width * 0.77,
                    height: Get.height * 0.06,
                    onPressed: () {},
                  ),
                  SizedBox(height: Get.height * 0.06),
                  ReBottomTextAuthScreenWidget(
                    text: "Already have an Account? ",
                    title: "Sign in",
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
