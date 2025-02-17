import 'package:anoncreds_wrapper_dart/anoncreds/enums/error_code.dart';

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

class NotImplementedException implements Exception {
  final String? fnName;

  NotImplementedException([this.fnName]);

  @override
  String toString() {
    return (fnName == null)
        ? "Function not implemented."
        : "Function '$fnName' is not implemented.";
  }
}
