import 'dart:convert';
import 'dart:ffi';

import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_native_functions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_native_types.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_native_utils.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/anoncreds_error_code.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/object_handle.dart';
import 'package:ffi/ffi.dart';

final class AnoncredsResult<T> {
  final ErrorCode errorCode;
  final T value;

  AnoncredsResult(this.errorCode, this.value);

  T getValueOrException() {
    if (errorCode == ErrorCode.success) {
      return value;
    }
    throw AnoncredsErrorCodeException(errorCode);
  }

  @override
  String toString() {
    return "AnoncredsResult($errorCode, $value)";
  }
}

String anoncredsVersion() {
  Pointer<Utf8> resultPointer = nullptr;

  try {
    resultPointer = nativeAnoncredsVersion();
    return resultPointer.toDartString();
  } finally {
    freePointer(resultPointer);
  }
}

AnoncredsResult<CredentialDefinition> anoncredsCredentialDefinitionFromJson(
    Map<String, dynamic> json) {
  Pointer<Int64> handlePtr = calloc<Int64>();

  Pointer<FfiByteBuffer> byteBufferPtr = nullptr;

  try {
    byteBufferPtr = stringToByteBuffer(jsonEncode(json));

    final errorCode = ErrorCode.fromInt(nativeAnoncredsCredentialDefinitionFromJson(
      byteBufferPtr,
      handlePtr,
    ));

    final handle =
        CredentialDefinition((errorCode == ErrorCode.success) ? handlePtr.value : 0);

    return AnoncredsResult(errorCode, handle);
  } finally {
    freePointer(handlePtr);
    freeByteBufferPointer(byteBufferPtr);
  }
}

void anoncredsObjectFree(ObjectHandle handle) {
  nativeAnoncredsObjectFree(handle.toInt());
}

AnoncredsResult<String> anoncredsObjectGetJson(ObjectHandle handle) {
  Pointer<FfiByteBuffer> byteBufferPtr = calloc<FfiByteBuffer>();

  try {
    final result = nativeAnoncredsObjectGetJson(handle.toInt(), byteBufferPtr);

    final errorCode = ErrorCode.fromInt(result);

    final value =
        (errorCode == ErrorCode.success) ? byteBufferToString(byteBufferPtr.ref) : "";

    return AnoncredsResult<String>(errorCode, value);
  } finally {
    freeByteBufferPointer(byteBufferPtr);
  }
}

AnoncredsResult<String> anoncredsObjectGetTypeName(ObjectHandle handle) {
  Pointer<Pointer<Utf8>> resultPtrPointer = calloc<Pointer<Utf8>>();

  try {
    final result = nativeAnoncredsObjectGetTypeName(
      handle.toInt(),
      resultPtrPointer,
    );

    final errorCode = ErrorCode.fromInt(result);

    final String value =
        (errorCode == ErrorCode.success) ? resultPtrPointer.value.toDartString() : "";

    return AnoncredsResult<String>(errorCode, value);
  } finally {
    freeDoublePointer(resultPtrPointer);
  }
}
