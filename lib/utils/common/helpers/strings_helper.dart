class StringsHelper {
  StringsHelper._();

  static bool isValidateEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidatePassword(String password) {
    return password.length >= 6;
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
