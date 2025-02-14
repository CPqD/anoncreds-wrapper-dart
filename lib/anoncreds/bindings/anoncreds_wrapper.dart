import 'dart:convert';
import 'dart:ffi';

import 'package:anoncreds_wrapper_dart/anoncreds/api/credential.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition_private.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_offer.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_request.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_request_metadata.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_revocation_state.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/key_correctness_proof.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/presentation.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/presentation_request.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/revocation_registry.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/revocation_registry_definition.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/revocation_registry_definition_private.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/revocation_status_list.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/schema.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/w3c_credential.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/w3c_presentation.dart';
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
  final result = _fromJson(json, nativeAnoncredsCredentialDefinitionFromJson);

  return AnoncredsResult(result.errorCode, CredentialDefinition(result.value));
}

AnoncredsResult<CredentialDefinitionPrivate> anoncredsCredentialDefinitionPrivateFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsCredentialDefinitionPrivateFromJson);

  return AnoncredsResult(result.errorCode, CredentialDefinitionPrivate(result.value));
}

AnoncredsResult<Credential> anoncredsCredentialFromJson(Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsCredentialFromJson);

  return AnoncredsResult(result.errorCode, Credential(result.value));
}

AnoncredsResult<CredentialOffer> anoncredsCredentialOfferFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsCredentialOfferFromJson);

  return AnoncredsResult(result.errorCode, CredentialOffer(result.value));
}

AnoncredsResult<CredentialRequest> anoncredsCredentialRequestFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsCredentialRequestFromJson);

  return AnoncredsResult(result.errorCode, CredentialRequest(result.value));
}

AnoncredsResult<CredentialRequestMetadata> anoncredsCredentialRequestMetadataFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsCredentialRequestMetadataFromJson);

  return AnoncredsResult(result.errorCode, CredentialRequestMetadata(result.value));
}

AnoncredsResult<KeyCorrectnessProof> anoncredsKeyCorrectnessProofFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsKeyCorrectnessProofFromJson);

  return AnoncredsResult(result.errorCode, KeyCorrectnessProof(result.value));
}

void anoncredsObjectFree(ObjectHandle handle) {
  nativeAnoncredsObjectFree(handle.handle);
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

AnoncredsResult<Presentation> anoncredsPresentationFromJson(Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsPresentationFromJson);

  return AnoncredsResult(result.errorCode, Presentation(result.value));
}

AnoncredsResult<PresentationRequest> anoncredsPresentationRequestFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsPresentationRequestFromJson);

  return AnoncredsResult(result.errorCode, PresentationRequest(result.value));
}

AnoncredsResult<RevocationRegistryDefinition>
    anoncredsRevocationRegistryDefinitionFromJson(Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsRevocationRegistryDefinitionFromJson);

  return AnoncredsResult(result.errorCode, RevocationRegistryDefinition(result.value));
}

AnoncredsResult<RevocationRegistryDefinitionPrivate>
    anoncredsRevocationRegistryDefinitionPrivateFromJson(Map<String, dynamic> json) {
  final result =
      _fromJson(json, nativeAnoncredsRevocationRegistryDefinitionPrivateFromJson);

  return AnoncredsResult(
      result.errorCode, RevocationRegistryDefinitionPrivate(result.value));
}

AnoncredsResult<RevocationRegistry> anoncredsRevocationRegistryFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsRevocationRegistryFromJson);

  return AnoncredsResult(result.errorCode, RevocationRegistry(result.value));
}

AnoncredsResult<CredentialRevocationState> anoncredsRevocationStateFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsRevocationStateFromJson);

  return AnoncredsResult(result.errorCode, CredentialRevocationState(result.value));
}

AnoncredsResult<RevocationStatusList> anoncredsRevocationStatusListFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsRevocationStateFromJson);

  return AnoncredsResult(result.errorCode, RevocationStatusList(result.value));
}

AnoncredsResult<Schema> anoncredsSchemaFromJson(Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsSchemaFromJson);

  return AnoncredsResult(result.errorCode, Schema(result.value));
}

AnoncredsResult<W3cCredential> anoncredsW3cCredentialFromJson(Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsW3cCredentialFromJson);

  return AnoncredsResult(result.errorCode, W3cCredential(result.value));
}

AnoncredsResult<W3cPresentation> anoncredsW3cPresentationFromJson(
    Map<String, dynamic> json) {
  final result = _fromJson(json, nativeAnoncredsW3cPresentationFromJson);

  return AnoncredsResult(result.errorCode, W3cPresentation(result.value));
}

AnoncredsResult<int> _fromJson(
  Map<String, dynamic> json,
  int Function(FfiByteBuffer, Pointer<Int64>) nativeFn,
) {
  Pointer<Int64> handlePtr = calloc<Int64>();

  Pointer<FfiByteBuffer> byteBufferPtr = nullptr;

  try {
    byteBufferPtr = stringToByteBuffer(jsonEncode(json));

    final errorCode = ErrorCode.fromInt(nativeFn(
      byteBufferPtr.ref,
      handlePtr,
    ));

    final handle = (errorCode == ErrorCode.success) ? handlePtr.value : 0;

    return AnoncredsResult(errorCode, handle);
  } finally {
    freePointer(handlePtr);
    freeByteBufferPointer(byteBufferPtr);
  }
}
