import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chatify/core/utils/state_util.dart';
import 'package:new_chatify/presentation/auth/bloc/bloc/auth_bloc.dart';
import 'package:new_chatify/presentation/auth/pages/signin_view.dart';
import 'package:new_chatify/presentation/auth/widgets/re_bottotextauthscreen_widget.dart';
import 'package:new_chatify/presentation/auth/widgets/re_button_widget.dart';
import 'package:new_chatify/presentation/auth/widgets/re_logo_widget.dart';
import 'package:new_chatify/presentation/auth/widgets/re_notloggedin_widget.dart';
import 'package:new_chatify/presentation/auth/widgets/re_remember_widget.dart';
import 'package:new_chatify/presentation/auth/widgets/re_textformfield_widget.dart';
import 'package:new_chatify/presentation/chatroomslist/pages/userlist_view.dart';

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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
          if (state is AuthSucceedState) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (_) {
                return const UserListView();
              },
            ), (route) => false);
          }
        },
        builder: (_, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReLogoWidget(),
                  SizedBox(height: 20),
                  CircularProgressIndicator(color: Color(0xFF31C48D)),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.10),
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
                        labelText: 'Email',
                      ),
                      SizedBox(height: Get.height * 0.02),
                      ReTextFormFieldWidget(
                        controller: _passwordController,
                        labelText: 'Password',
                      ),
                      SizedBox(height: Get.height * 0.02),
                      const ReRememberWidget(),
                      SizedBox(height: Get.height * 0.03),
                      ReButtonWidget(
                        title: "Sign up",
                        width: Get.width * 0.77,
                        height: Get.height * 0.06,
                        onPressed: () => context.read<AuthBloc>().add(
                              AuthSignupRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            ),
                      ),
                      SizedBox(height: Get.height * 0.06),
                      ReBottomTextAuthScreenWidget(
                        text: "Already have an Account? ",
                        title: "Sign in",
                        onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SigninView()),
                            (route) => false),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
