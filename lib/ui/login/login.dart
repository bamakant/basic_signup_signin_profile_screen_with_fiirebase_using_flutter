import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kodehash_assignment/ui/login/login_notifier.dart';
import 'package:kodehash_assignment/utils/extentions/int_extention.dart';
import 'package:kodehash_assignment/utils/string_utils.dart';
import 'package:kodehash_assignment/utils/widgets/custom_buttons.dart';
import 'package:kodehash_assignment/utils/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = LoginNotifier(context);
    _notifier.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _notifier,
      child: Scaffold(body: _body()),
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              32.height,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringUtils.login,
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(35, 85, 252, 1),
                  ),
                ),
              ),
              40.height,
              _emailFieldWidget(),
              24.height,
              _passwordFieldWidget(),
              24.height,
              _submitButtonWidget(),
              32.height,
              _signUpButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailFieldWidget() {
    return Consumer<LoginNotifier>(
      builder: (BuildContext context, value, Widget? child) =>
          CustomTextFormField(
        horizontalPadding: 0,
        fontSize: 18,
        controller: _notifier.emailController,
        validator: _notifier.validateEmail,
        hintText: StringUtils.enterEmail,
        labelText: StringUtils.email,
        errorText: _notifier.emailErrorText,
        focusNode: _notifier.focusNodeEmail,
        onChange: _notifier.onChangeEmail,
      ),
    );
  }

  Widget _passwordFieldWidget() {
    return Consumer<LoginNotifier>(
      builder: (context, value, child) => CustomTextFormField(
        onChange: _notifier.onChangePassword,
        horizontalPadding: 0,
        fontSize: 18,
        isPassword: !_notifier.passwordVisible,
        suffixIcon: _notifier.passwordVisible
            ? GestureDetector(
                onTap: () => _notifier.onClickEye(),
                child: SvgPicture.asset(
                  'assets/images/eye_blue.svg',
                  height: 10,
                  width: 10,
                ),
              )
            : GestureDetector(
                onTap: () => _notifier.onClickEye(),
                child: SvgPicture.asset(
                  'assets/images/eye_grey.svg',
                  height: 10,
                  width: 10,
                ),
              ),
        controller: _notifier.passwordController,
        validator: _notifier.validatePassword,
        hintText: StringUtils.enterPassword,
        labelText: StringUtils.password,
        errorText: _notifier.passwordErrorText,
        focusNode: _notifier.focusNodePassword,
      ),
    );
  }

  Widget _submitButtonWidget() {
    return Consumer<LoginNotifier>(
      builder: (BuildContext context, value, Widget? child) => Hero(
        tag: 'heroAnimation',
        child: Row(
          children: [
            Expanded(
              child: CustomButtons.filledButton(
                  text: StringUtils.submit,
                  onPressed: _notifier.onClickSubmit,
                  isEnabled: _notifier.enableSubmitButton),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpButtonWidget() {
    return Hero(
      tag: 'heroSignup',
      child: Row(
        children: [
          Expanded(
            child: CustomButtons.outlinedButton(
                text: StringUtils.signUp,
                radius: 4,
                onPressed: _notifier.onClickSignUp,
                isEnabled: true),
          ),
        ],
      ),
    );
  }
}
