import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text('Get Started With',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(
                height: 16,
              ),
              _buildSignInForm(),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Column(children: [
                TextButton(
                    onPressed: _onTapForgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )),
                _buildSignUpSection(),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
        text: TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
            children: [
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: AppColors.themeColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp)
        ]));
  }

  Widget _buildSignInForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
            onPressed: _onTapNextButton, child: Icon(Icons.arrow_forward_ios)),
      ],
    );
  }

  void _onTapNextButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainBottomNavBarScreen()),
        (_) => false);
  }

  void _onTapForgotPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }
}
