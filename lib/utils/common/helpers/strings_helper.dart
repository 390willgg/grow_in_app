import 'package:grow_in_app/utils/constants/text_strings.dart';

import '../../error/failure.dart';

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

  static String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailure;
      case const (OfflineFailure):
        return offlineFailure;
      case const (WeakPasswordFailure):
        return weakPassword;
      case const (ExistedAccountFailure):
        return existedAccount;
      case const (NoUserFailure):
        return noUser;
      case const (TooManyRequestsFailure):
        return tooManyRequests;
      case const (WrongPasswordFailure):
        return wrongPassword;
      case const (UnmatchedPasswordFailure):
        return unmatchedPassword;
      case const (NotLoggedInFailure):
        return '';
      default:
        return 'Unexpected Error';
    }
  }
}
