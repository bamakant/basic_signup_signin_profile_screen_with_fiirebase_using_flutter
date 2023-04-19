import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kodehash_assignment/ui/signup/signup_notifier.dart';
import 'package:kodehash_assignment/utils/extentions/int_extention.dart';
import 'package:kodehash_assignment/utils/string_utils.dart';
import 'package:kodehash_assignment/utils/widgets/custom_buttons.dart';
import 'package:kodehash_assignment/utils/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final bool? isFromLogin;
  final dynamic userData;
  final String? userId;

  const SignUp({Key? key, this.isFromLogin, this.userData, this.userId})
      : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late SignUpNotifier _notifier;
  late bool isFromLogin;

  @override
  void initState() {
    super.initState();
    _notifier = SignUpNotifier(context);
    isFromLogin = widget.isFromLogin ?? false;
    _notifier.init(widget.userData, isFromLogin, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _notifier,
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            32.height,
            Align(
              alignment: Alignment.topLeft,
              child: Hero(
                tag: 'heroSignup',
                child: Text(
                  isFromLogin ? StringUtils.profile : StringUtils.signUp,
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(35, 85, 252, 1),
                  ),
                ),
              ),
            ),
            8.height,
            _profileImageWidget(),
            24.height,
            _emailFieldWidget(),
            24.height,
            _passwordFieldWidget(),
            24.height,
            _nameFieldWidget(),
            24.height,
            _mobileFieldWidget(),
            24.height,
            _descriptionFieldFieldWidget(),
            32.height,
            _submitButtonWidget(),
          ],
        ),
      ),
    );
  }

  Widget _emailFieldWidget() {
    return Consumer<SignUpNotifier>(
      builder: (BuildContext context, value, Widget? child) =>
          CustomTextFormField(
        horizontalPadding: 0,
        fontSize: 18,
        controller: _notifier.emailController,
        validator: _notifier.validateEmail,
        hintText: StringUtils.enterEmail,
        labelText: StringUtils.email,
        errorText: _notifier.emailErrorText,
        focusNode: _notifier.emailFocusNode,
        onChange: _notifier.onChangeEmail,
      ),
    );
  }

  Widget _passwordFieldWidget() {
    return Consumer<SignUpNotifier>(
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
        focusNode: _notifier.passwordFocusNode,
      ),
    );
  }

  Widget _nameFieldWidget() {
    return Consumer<SignUpNotifier>(
      builder: (BuildContext context, value, Widget? child) =>
          CustomTextFormField(
        horizontalPadding: 0,
        controller: _notifier.nameController,
        hintText: StringUtils.enterName,
        labelText: StringUtils.labelName,
        focusNode: _notifier.nameFocusNode,
        onChange: _notifier.onChangeName,
      ),
    );
  }

  Widget _mobileFieldWidget() {
    return Consumer<SignUpNotifier>(
      builder: (BuildContext context, value, Widget? child) =>
          CustomTextFormField(
        horizontalPadding: 0,
        controller: _notifier.mobileController,
        hintText: StringUtils.enterMobile,
        labelText: StringUtils.labelMobile,
        errorText: _notifier.mobileErrorText,
        focusNode: _notifier.mobileFocusNode,
        validator: _notifier.validateMobile,
        onChange: _notifier.onChangeMobile,
        textInputType: TextInputType.number,
        maxLength: 10,
      ),
    );
  }

  Widget _descriptionFieldFieldWidget() {
    return Consumer<SignUpNotifier>(
      builder: (BuildContext context, value, Widget? child) =>
          CustomTextFormField(
        horizontalPadding: 0,
        maxLines: 5,
        controller: _notifier.descriptionController,
        hintText: StringUtils.enterDescription,
        labelText: StringUtils.description,
        onChange: _notifier.onChangeDescription,
      ),
    );
  }

  Widget _submitButtonWidget() {
    return Consumer<SignUpNotifier>(
      builder: (BuildContext context, value, Widget? child) => Row(
        children: [
          Expanded(
            child: CustomButtons.filledButton(
                text: isFromLogin ? StringUtils.update : StringUtils.submit,
                onPressed: _notifier.onClickSubmit,
                isEnabled: _notifier.enableSubmitButton),
          ),
        ],
      ),
    );
  }

  Widget _profileImageWidget() {
    return isFromLogin
        ? Center(
            child: Consumer<SignUpNotifier>(
              builder: (BuildContext context, value, Widget? child) => Hero(
                tag: 'heroAnimation',
                child: GestureDetector(
                  onTap: () => _notifier.onClickProfile(),
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: _notifier.localProfileImagePath != null
                            ? Image.file(
                                _notifier.localProfileImagePath!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                _notifier.profileUrl.isNotEmpty
                                    ? _notifier.profileUrl
                                    : 'https://www.solidbackgrounds.com/images/1920x1080/1920x1080-gray-solid-color-background.jpg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
