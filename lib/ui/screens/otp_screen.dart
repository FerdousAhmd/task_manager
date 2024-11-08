import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/set_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class otpScreen extends StatefulWidget {
  const otpScreen({super.key, required this.email});

  final String email;

  @override
  State<otpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<otpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _getOTPTEController = TextEditingController();
  bool _inprogress = false;

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
                Text('Pin Verification',
                    style: textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(
                  'A 6 digits verification otp has been sent to your email address.',
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

  Widget _buildHaveAccountSection() {
    return RichText(
        text: TextSpan(
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
          PinCodeTextField(
            controller: _getOTPTEController,
            length: 6,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.white),
            animationDuration: Duration(milliseconds: 200),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            appContext: context,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your OTP';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inprogress,
            replacement: CircularProgressIndicator(),
            child: ElevatedButton(
                onPressed: _onTapNextButton,
                child: Icon(Icons.arrow_forward_ios)),
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _otp();
  }

  Future<void> _otp() async {
    _inprogress = true;
    setState(() {});
    final String email = widget.email;
    final String urlsPath =
        '${urls.recoverVerifyOtp}/${email}/${_getOTPTEController.text.trim()}';
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: urlsPath);
    _inprogress = false;
    setState(() {});
    if (response.isSuccess) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ResetPasswordScreen(
          email: email,
          otp: int.parse(_getOTPTEController.text),
        );
      }));
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (_) => false);
  }
}
