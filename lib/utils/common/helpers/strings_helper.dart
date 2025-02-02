import 'regex_helper.dart';
import '../../constants/text_strings.dart';

import '../../error/failure.dart';

class StringsHelper {
  StringsHelper._();

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

  static String? checkFormatEmail(String? email) {
    if (email == null || email.isEmpty) {
      return pleaseFillTheForm;
    } else if (!RegexHelper.isValidEmail(email)) {
      return pleaseFillValidEmail;
    }
    return null;
  }

  static String? checkPasswordFormat(String? password) {
    if (password == null || password.isEmpty) {
      return pleaseFillTheForm;
    } else if (!RegexHelper.isValidPassword(password)) {
      return pleaseFillValidPassword;
    }
    return null;
  }
}
