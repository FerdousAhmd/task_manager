import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/otp_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text('Your Email Address',
                    style: textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w600)
                ),
                Text('A 6 digits verification otp will sent to your email address.',
                style: textTheme.titleMedium
                  ?.copyWith(color: Colors.grey,
                fontWeight: FontWeight.w500,
                ),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildVerifyEmailForm(),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Column(
                        children: [

                          _buildHaveAccountSection(),

                        ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapForgotPassword(){
    //TODO: imlement on tap forgot password
  }

  Widget _buildHaveAccountSection() {
    return RichText(
        text:  TextSpan(
            text: "Have an account!  ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,

            ),
            children: [
              TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    color: AppColors.themeColor,),
                  recognizer: TapGestureRecognizer()..onTap = _onTapSignIn
              )
            ])
    );
  }

  Widget _buildVerifyEmailForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
          ),
        ),

        const SizedBox(
          height: 24,
        ),
        ElevatedButton(onPressed: _onTapNextButton,
            child: Icon(Icons.arrow_forward_ios)),
      ],
    );
  }

  void _onTapNextButton(){
   Navigator.push(context, MaterialPageRoute(builder: (context) => otpScreen()));
  }

  void _onTapSignIn(){
    Navigator.pop(context);

  }
}
