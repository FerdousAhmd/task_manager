import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  final String email;
  final int otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();
  bool _inprogress = true;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 90,
              ),
              Text('Set Password',
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 8.0,
              ),
              Text('Minimum number of password should be 8 letters',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey)),
              const SizedBox(
                height: 24,
              ),
              builResetPassword(),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Column(
                  children: [
                    buildSignInSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget buildSignInSection() {
    return RichText(
        text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.75,
            ),
            text: "Have an Account? ",
            children: [
          TextSpan(
              style: TextStyle(color: AppColors.themeColor),
              text: 'Sign In',
              recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton)
        ]));
  }

  Widget builResetPassword() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passTEController,
            decoration: InputDecoration(hintText: 'Password'),
            keyboardType: TextInputType.text,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a new password';
              }
              if (value!.length < 8) {
                return 'Enter minimum 8 digit password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            controller: _confirmPassTEController,
            decoration: InputDecoration(hintText: 'Confirm password'),
            keyboardType: TextInputType.text,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a confirm password';
              }
              if (value!.length < 8) {
                return 'Enter minimum 8 digit password';
              }
              if (value != _passTEController.text) {
                return 'password do not match';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 34.0,
          ),
          ElevatedButton(
              onPressed: () {
                _onTapNextButton();
              },
              child: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _passwordReset();
  }

  Future<void> _passwordReset() async {
    _inprogress = true;
    setState(() {});
    final String email = widget.email;
    final int otp = widget.otp;
    Map<String, dynamic> _reqBody = {
      "email": email,
      "OTP": otp.toString(),
      "password": _passTEController.text
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: urls.recoverResestPassword,
      body: _reqBody,
    );
    _inprogress = false;
    setState(() {});
    if (response.isSuccess) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return SignInScreen();
      }), (_) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return SignInScreen();
    }), (_) => false);
  }
}
