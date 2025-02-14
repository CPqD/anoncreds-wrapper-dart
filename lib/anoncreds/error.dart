class AnoncredsErrorObject {
  final int code;
  final String? extra;
  final String message;

  AnoncredsErrorObject({
    required this.code,
    required this.message,
    this.extra,
  });
}

class AnoncredsError implements Exception {
  final int code;
  final String? extra;
  final String message;

  AnoncredsError({
    required this.code,
    required this.message,
    this.extra,
  });

  @override
  String toString() {
    return 'AnoncredsError: $message (code: $code, extra: $extra)';
  }

  static AnoncredsError customError({required String message}) {
    return AnoncredsError(code: 100, message: message);
  }
}

T handleInvalidNullResponse<T>(T response) {
  if (response == null) {
    throw AnoncredsError.customError(
        message: 'Invalid response. Expected value but received null pointer');
  }

  return response;
}
