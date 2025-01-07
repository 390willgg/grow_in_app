class GeneralException implements Exception {
  final String message;

  const GeneralException({required this.message});
}

class ServerException implements Exception {
  final String message;

  const ServerException({required this.message});
}

class OfflineException implements Exception {
  final String message;

  const OfflineException({required this.message});
}

class StatusCodeException implements Exception {
  final String message;

  const StatusCodeException({required this.message});
}

class EmptyException implements Exception {
  final String message;

  const EmptyException({required this.message});
}

//Auth Area
class WeakPasswordException implements Exception {
  final String message;

  const WeakPasswordException({required this.message});
}

class ExistedAccountException implements Exception {
  final String message;

  const ExistedAccountException({required this.message});
}

class NoUserException implements Exception {
  final String message;

  const NoUserException({required this.message});
}

class WrongPasswordException implements Exception {
  final String message;

  const WrongPasswordException({required this.message});
}

class TooManyRequestException implements Exception {
  final String message;

  const TooManyRequestException({required this.message});
}
