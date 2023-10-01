import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kodehash_assignment/config/route.dart';
import 'package:kodehash_assignment/ui/signup/signup.dart';
import 'package:kodehash_assignment/utils/string_utils.dart';
import 'package:kodehash_assignment/utils/validation_utils.dart';

class LoginNotifier with ChangeNotifier {
  late BuildContext context;

  bool enableSubmitButton = false, passwordVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode(), focusNodePassword = FocusNode();

  String emailErrorText = '', passwordErrorText = '';

  LoginNotifier(this.context);

  void init() {
    emailController.addListener(() {
      emailController.selection = TextSelection.fromPosition(
          TextPosition(offset: emailController.text.length));
    });
    passwordController.addListener(() {
      passwordController.selection = TextSelection.fromPosition(
          TextPosition(offset: passwordController.text.length));
    });
  }

  void validateEmail(String? value) {
    if (emailController.text.isEmpty) {
      emailErrorText = StringUtils.emailEmptyErrorMessage;
    } else if (emailController.text.isNotEmpty &&
        !Validator.isEmailValid(emailController.text)) {
      emailErrorText = StringUtils.emailErrorMessage;
    } else {
      emailErrorText = '';
    }
    shouldEnableLoginButton();
  }

  void onChangeEmail(String? value) {
    emailController.text = value ?? '';
    validateEmail(value);
  }

  void validatePassword(String? value) {
    if (passwordController.text.isEmpty) {
      passwordErrorText = StringUtils.passwordEmptyErrorMessage;
    } else {
      passwordErrorText = '';
    }
    shouldEnableLoginButton();
  }

  void onChangePassword(String? value) {
    passwordController.text = value ?? '';
    validatePassword(value);
  }

  void onClickEye() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void shouldEnableLoginButton() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailErrorText.isEmpty &&
        passwordErrorText.isEmpty) {
      enableSubmitButton = true;
    } else {
      enableSubmitButton = false;
    }
    notifyListeners();
  }

  void onClickSubmit() {
    try {
      FirebaseDatabase.instance
          .reference()
          .child('users')
          .orderByChild('email')
          .equalTo(emailController.text)
          .once()
          .then((event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic>? usersList =
            snapshot.value as Map<dynamic, dynamic>?;

        if (usersList != null) {
          usersList.forEach((key, value) {
            if (value['password'] == passwordController.text) {
              passwordErrorText = '';
              emailErrorText = '';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignUp(
                    isFromLogin: true,
                    userId: key,
                    userData: value,
                  ),
                ),
              );
            } else {
              passwordErrorText = StringUtils.incorrectPassword;
              notifyListeners();
            }
          });
        } else {
          emailErrorText = StringUtils.emailNotFound;
          notifyListeners();
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong."),
        ),
      );
    }
  }

  void onClickSignUp() {
    Navigator.pushNamed(context, Routes.signupRoute);
  }
}
