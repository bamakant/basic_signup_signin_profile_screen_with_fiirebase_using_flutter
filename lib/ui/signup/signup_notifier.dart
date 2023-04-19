import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kodehash_assignment/config/route.dart';
import 'package:kodehash_assignment/utils/string_utils.dart';
import 'package:kodehash_assignment/utils/validation_utils.dart';

class SignUpNotifier with ChangeNotifier {
  late BuildContext context;
  bool enableSubmitButton = false, passwordVisible = false, isFromLogin = false;

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController(),
      mobileController = TextEditingController(),
      descriptionController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode(),
      passwordFocusNode = FocusNode(),
      nameFocusNode = FocusNode(),
      mobileFocusNode = FocusNode(),
      descriptionFocusNode = FocusNode();

  String emailErrorText = '',
      passwordErrorText = '',
      mobileErrorText = '',
      profileUrl = '';

  String? userId;

  File? localProfileImagePath;

  dynamic userData;

  SignUpNotifier(this.context);

  void init(dynamic user, bool fromLogin, String? id) {
    userData = user;
    isFromLogin = fromLogin;
    userId = id;

    if (userData != null) {
      profileUrl = userData['profileUrl'] ?? '';
      emailController.text = userData['email'];
      passwordController.text = userData['password'];
      nameController.text = userData['name'];
      mobileController.text = userData['mobile'];
      descriptionController.text = userData['description'];
      enableSubmitButton = true;
    }

    emailController.addListener(() {
      emailController.selection = TextSelection.fromPosition(
          TextPosition(offset: emailController.text.length));
    });
    passwordController.addListener(() {
      passwordController.selection = TextSelection.fromPosition(
          TextPosition(offset: passwordController.text.length));
    });
    nameController.addListener(() {
      nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: nameController.text.length));
    });
    mobileController.addListener(() {
      mobileController.selection = TextSelection.fromPosition(
          TextPosition(offset: mobileController.text.length));
    });
    descriptionController.addListener(() {
      descriptionController.selection = TextSelection.fromPosition(
          TextPosition(offset: descriptionController.text.length));
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
    shouldEnableContinueButton();
  }

  void onChangeEmail(String? value) {
    emailController.text = value ?? '';
    validateEmail(value);
  }

  void validatePassword(String? value) {
    if (passwordController.text.isEmpty) {
      passwordErrorText = StringUtils.passwordEmptyErrorMessage;
    } else if (passwordController.text.isNotEmpty &&
        passwordController.text.length < 6) {
      passwordErrorText = StringUtils.passwordLengthErrorMessage;
    } else {
      passwordErrorText = '';
    }
    shouldEnableContinueButton();
  }

  void onChangePassword(String? value) {
    passwordController.text = value ?? '';
    validatePassword(value);
  }

  void validateMobile(String? value) {
    if (mobileController.text.isNotEmpty &&
        !Validator.isValidPhoneNumber(mobileController.text)) {
      mobileErrorText = StringUtils.mobileErrorMessage;
    } else {
      mobileErrorText = '';
    }
    shouldEnableContinueButton();
  }

  void onChangeMobile(String? value) {
    mobileController.text = value ?? '';
    validateMobile(value);
  }

  void shouldEnableContinueButton() {
    if (passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordErrorText.isEmpty &&
        emailErrorText.isEmpty &&
        mobileController.text.isNotEmpty &&
        mobileErrorText.isEmpty) {
      enableSubmitButton = true;
    } else {
      enableSubmitButton = false;
    }
    notifyListeners();
  }

  void onClickEye() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void onChangeName(String? value) {
    nameController.text = value ?? '';
    notifyListeners();
  }

  Future<void> onClickSubmit() async {
    if (isFromLogin) {
      //update the user data
      if (localProfileImagePath != null) {
        final Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('user_images').child(userId!);
        final TaskSnapshot uploadProfileTask =
            await firebaseStorageRef.putFile(localProfileImagePath!);
        if (uploadProfileTask.state == TaskState.success) {
          profileUrl = await firebaseStorageRef.getDownloadURL();
        }
      }
      final DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(userId!);

      final Map<String, dynamic> userDataUpdate = <String, dynamic>{
        'profileUrl': profileUrl,
        'email': emailController.text,
        'password': passwordController.text,
        'name': nameController.text,
        'mobile': mobileController.text,
        'description': descriptionController.text
      };

      await userRef.update(userDataUpdate);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Update successful."),
        ),
      );
    } else {
      //create new user
      try {
        FirebaseDatabase.instance.ref().child('users').push().set({
          'email': emailController.text,
          'password': passwordController.text,
          'name': nameController.text,
          'mobile': mobileController.text,
          'description': descriptionController.text
          // add other properties as needed
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign up successful. Please login to continue."),
          ),
        );
        Navigator.pushNamed(context, Routes.loginRoute);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong."),
          ),
        );
      }
    }
  }

  onChangeDescription(String? value) {
    descriptionController.text = value ?? '';
    notifyListeners();
  }

  void onClickProfile() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    localProfileImagePath = pickedImage != null ? File(pickedImage.path) : null;
    notifyListeners();
  }
}
