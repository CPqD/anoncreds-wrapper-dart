import 'package:anoncreds_wrapper_dart/anoncreds/enums/anoncreds_error_code.dart';

class AnoncredsErrorCodeException extends AnoncredsException {
  final ErrorCode errorCode;

  AnoncredsErrorCodeException(this.errorCode);

  @override
  String toString() {
    return "Invalid Error Code: $errorCode";
  }
}

class AnoncredsException implements Exception {
  final String? message;

  AnoncredsException([this.message]);

  @override
  String toString() {
    if (message == null) return "Askar Exception";
    return "Askar Exception: $message";
  }
}
