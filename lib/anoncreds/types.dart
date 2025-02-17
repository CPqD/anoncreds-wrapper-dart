import 'dart:typed_data';

import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition_private.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/key_correctness_proof.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/error_code.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

class ByteBufferOptions {
  final int len;
  final Uint8List data;

  ByteBufferOptions({required this.len, required this.data});
}

class ByteBuffer {
  final int len;
  final Uint8List data;

  ByteBuffer({required this.data, required this.len});

  factory ByteBuffer.fromUint8List(Uint8List data) {
    return ByteBuffer(data: data, len: data.length);
  }
}

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

final class CredentialDefinitionCreation {
  final CredentialDefinition credentialDefinition;
  final CredentialDefinitionPrivate credentialDefinitionPrivate;
  final KeyCorrectnessProof keyCorrectnessProof;

  CredentialDefinitionCreation(
    this.credentialDefinition,
    this.credentialDefinitionPrivate,
    this.keyCorrectnessProof,
  );

  @override
  String toString() {
    return "CredentialDefinitionCreation($credentialDefinition, $credentialDefinitionPrivate, $keyCorrectnessProof)";
  }
}
