class CustomException implements Exception {
  final String? _message;
  final String? _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException(String message)
      : super(
          message,
          "Error During Communication: ",
        );
}

class BadRequestException extends CustomException {
  BadRequestException(String message)
      : super(
          message.substring(1, message.length - 1),
          "Unauthorised: ",
        );
}

class UnauthorisedException extends CustomException {
  UnauthorisedException(String message)
      : super(
          message.substring(1, message.length - 1),
          "Forbidden: ",
        );
}

class InvalidInputException extends CustomException {
  InvalidInputException(String message)
      : super(
          message.substring(1, message.length - 1),
          "Internal Server Error: ",
        );
}
