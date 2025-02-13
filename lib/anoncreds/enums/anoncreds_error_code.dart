import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

enum ErrorCode {
  success(0),
  input(1),
  ioError(2),
  invalidState(3),
  unexpected(4),
  credentialRevoked(5),
  invalidUserRevocId(6),
  proofRejected(7),
  revocationRegistryFull(8);

  final int code;
  const ErrorCode(this.code);

  static ErrorCode fromInt(int code) {
    return ErrorCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => throw ArgumentError('Invalid error code: $code'),
    );
  }

  bool isSuccess() {
    return (code == ErrorCode.success.code);
  }

  void throwOnError() {
    if (!isSuccess()) {
      throw AnoncredsErrorCodeException(ErrorCode.fromInt(code));
    }
  }
}
