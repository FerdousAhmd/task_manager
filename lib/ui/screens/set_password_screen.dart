import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/otp_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SetPasswordScreen> {
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
                Text('Set Password',
                    style: textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w600)
                ),
                Text('Minimum number of password should be 8 letetrs.',
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

  Widget _buildVerifyEmailForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'New Password',
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Confirm Password',
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  void _onTapSignIn(){
    Navigator.pop(context);

  }
}
