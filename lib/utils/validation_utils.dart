class Validator {
  static bool isEmailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  static bool isValidPhoneNumber(String value) {
    if (value.length <= 10) {
      return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);
    } else {
      return false;
    }
  }
}
