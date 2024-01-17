import 'package:flutter/widgets.dart';
import 'package:new_chatify/views/signin_view.dart';
import 'package:new_chatify/views/signup_view.dart';

class SignupOrSigninView extends StatefulWidget {
  const SignupOrSigninView({super.key});

  @override
  State<SignupOrSigninView> createState() => _SignupOrSigninViewState();
}

class _SignupOrSigninViewState extends State<SignupOrSigninView> {
  bool isSigninView = false;

  void toogle() {
    setState(() {
      isSigninView = !isSigninView;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSigninView) {
      return SigninView(toogle: toogle());
    }
    return SignupView(toogle: toogle());
  }
}
