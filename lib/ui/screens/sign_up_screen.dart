import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailTEController = TextEditingController();
final TextEditingController _firstnameTEController = TextEditingController();
final TextEditingController _lastnameTEController = TextEditingController();
final TextEditingController _mobileTEController = TextEditingController();
final TextEditingController _passwordTEController = TextEditingController();
bool _inProgress = false;

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
            text: "Have an account! ",
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

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Email.';
              }
            },
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _firstnameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'First name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid First Name';
              }
            },
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _lastnameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: "Last name",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Last Name.';
              }
            },
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _mobileTEController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: "Mobile",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Mobile.';
              }
            },
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: "Password",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Password.';
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inProgress,
            replacement: const CenteredCircularProgressIndicator(),
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
    _signUp();
  }

    Future<void> _signUp() async {
      _inProgress = true;
      setState(() {});

      Map<String, dynamic> requestBody = {
        "email": _emailTEController.text.trim(),
        "firstName": _firstnameTEController.text.trim(),
        "lastName": _lastnameTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
        "password": _passwordTEController.text,
        "photo": ""
      };
       NetworkResponse response =
      await NetworkCaller.postRequest(
        url: urls.registration,
        body: requestBody,
      );
       _inProgress=false;
       setState(() {
       });
      if (response.isSuccess) {
        _clearTextFields();
        showSnackBarMessage(context, 'New user created');
      } else {
        showSnackBarMessage(context, response.errorMessage);
      }
    }

 void _clearTextFields(){
    _emailTEController.clear();
    _firstnameTEController.clear();
    _lastnameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
 }

  void _onTapSignIn() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEController;
    _firstnameTEController;
    _lastnameTEController;
    _mobileTEController;
    _passwordTEController;
    super.dispose();
  }
}
