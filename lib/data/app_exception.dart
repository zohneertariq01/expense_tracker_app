class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  String toString() {
    return '$_message$_prefix';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, '');
}

class InvalidRequestException extends AppException {
  InvalidRequestException([String? message]) : super(message, '');
}

class UnauthorizedRequestException extends AppException {
  UnauthorizedRequestException([String? message]) : super(message, '');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, '');
}
