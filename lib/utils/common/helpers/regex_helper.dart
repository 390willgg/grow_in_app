import '../../constants/text_strings.dart';

class RegexHelper {
  RegexHelper._();
  static final RegExp _emailRegExp = RegExp(emailRegex);
  static final RegExp _passwordRegExp = RegExp(passwordRegex);

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
