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
  FetchDataException(message) : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException(message)
      : super(message.substring(1, message.length - 1), "Unauthorised: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException(message)
      : super(message.substring(1, message.length - 1), "Forbidden: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException(message)
      : super(message.substring(1, message.length - 1),
            "Internal Server Error: ");
}
