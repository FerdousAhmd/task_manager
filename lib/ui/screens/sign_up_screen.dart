import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
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
                Text('Join With Us',
                    style: textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 16,
                ),
                _buildSignUpForm(),
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
              letterSpacing: 0.5,
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

  Widget _buildSignUpForm() {
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
        SizedBox(height: 8,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'First name'
          ),
        ),
        SizedBox(height: 8,),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Last name",
          ),
        ),
        SizedBox(height: 8,),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "Mobile",
          ),
        ),
        SizedBox(height: 8,),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Password",
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
    //TODO: implement on tap next button.
  }

  void _onTapSignIn(){
    Navigator.pop(context);

  }
}
