import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/otp_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static TextEditingController _emailTEController = TextEditingController();
  bool _inProgress = true;

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
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(
                  'A 6 digits verification otp will sent to your email address.',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
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
                    child: Column(children: [
                  _buildHaveAccountSection(),
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapForgotPassword() {
    //TODO: imlement on tap forgot password
  }

  Widget _buildHaveAccountSection() {
    return RichText(
        text: TextSpan(
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
                color: AppColors.themeColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn)
        ]));
  }

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid email.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: _onTapNextButton,
              child: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _forgotEmail();
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }

  Future<void> _forgotEmail() async {
    _inProgress = true;
    setState(() {});
    final String params =
        '${urls.forgotEmail}/${_emailTEController.text.trim()}';
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: params);
    _inProgress = false;
    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => otpScreen(
                  email: _emailTEController.text,
                )),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
