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
import 'package:anoncreds_wrapper_dart/anoncreds/enums/error_code.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/signature_type.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/types.dart';
import 'package:ffi/ffi.dart';

import 'object_handle.dart';

class NativeCredentialEntry {
  final ObjectHandle credential;
  final int? timestamp;
  final ObjectHandle? revocationState;

  NativeCredentialEntry({
    required this.credential,
    this.timestamp,
    this.revocationState,
  });
}

class NativeCredentialProve {
  final int entryIndex;
  final String referent;
  final bool isPredicate;
  final bool reveal;

  NativeCredentialProve({
    required this.entryIndex,
    required this.referent,
    required this.isPredicate,
    required this.reveal,
  });
}

class NativeNonRevokedIntervalOverride {
  final String revocationRegistryDefinitionId;
  final int requestedFromTimestamp;
  final int overrideRevocationStatusListTimestamp;

  NativeNonRevokedIntervalOverride({
    required this.revocationRegistryDefinitionId,
    required this.requestedFromTimestamp,
    required this.overrideRevocationStatusListTimestamp,
  });
}

class NativeRevocationEntry {
  final int revocationRegistryDefinitionEntryIndex;
  final ObjectHandle entry;
  final int timestamp;

  NativeRevocationEntry({
    required this.revocationRegistryDefinitionEntryIndex,
    required this.entry,
    required this.timestamp,
  });
}

class NativeCredentialRevocationConfig {
  final ObjectHandle revocationRegistryDefinition;
  final ObjectHandle revocationRegistryDefinitionPrivate;
  final ObjectHandle revocationStatusList;
  final int registryIndex;

  NativeCredentialRevocationConfig({
    required this.revocationRegistryDefinition,
    required this.revocationRegistryDefinitionPrivate,
    required this.revocationStatusList,
    required this.registryIndex,
  });
}

abstract class IAnoncreds {
  String version();

  String getCurrentError();
  void setDefaultLogger();

  String generateNonce();

  ObjectHandle createSchema({
    required String name,
    required String version,
    required String issuerId,
    required List<String> attributeNames,
  });

  AnoncredsResult<CredentialDefinitionCreation> createCredentialDefinition({
    required String schemaId,
    required ObjectHandle schemaHandle,
    required String tag,
    required String issuerId,
    required SignatureType signatureType,
    required bool supportRevocation,
  });

  ObjectHandle createCredential({
    required ObjectHandle credentialDefinition,
    required ObjectHandle credentialDefinitionPrivate,
    required ObjectHandle credentialOffer,
    required ObjectHandle credentialRequest,
    required Map<String, String> attributeRawValues,
    Map<String, String>? attributeEncodedValues,
    NativeCredentialRevocationConfig? revocationConfiguration,
  });

  List<String> encodeCredentialAttributes({
    required List<String> attributeRawValues,
  });

  ObjectHandle processCredential({
    required ObjectHandle credential,
    required ObjectHandle credentialRequestMetadata,
    required String linkSecret,
    required ObjectHandle credentialDefinition,
    ObjectHandle? revocationRegistryDefinition,
  });

  ObjectHandle createCredentialOffer({
    required String schemaId,
    required String credentialDefinitionId,
    required ObjectHandle keyCorrectnessProof,
  });

  Map<String, ObjectHandle> createCredentialRequest({
    String? entropy,
    String? proverDid,
    required ObjectHandle credentialDefinition,
    required String linkSecret,
    required String linkSecretId,
    required ObjectHandle credentialOffer,
  });

  AnoncredsResult<String> createLinkSecret();

  ObjectHandle createPresentation({
    required ObjectHandle presentationRequest,
    required List<NativeCredentialEntry> credentials,
    required List<NativeCredentialProve> credentialsProve,
    required Map<String, String> selfAttest,
    required String linkSecret,
    required Map<String, ObjectHandle> schemas,
    required Map<String, ObjectHandle> credentialDefinitions,
  });

  bool verifyPresentation({
    required ObjectHandle presentation,
    required ObjectHandle presentationRequest,
    required List<ObjectHandle> schemas,
    required List<String> schemaIds,
    required List<ObjectHandle> credentialDefinitions,
    required List<String> credentialDefinitionIds,
    List<ObjectHandle>? revocationRegistryDefinitions,
    List<String>? revocationRegistryDefinitionIds,
    List<ObjectHandle>? revocationStatusLists,
    List<NativeNonRevokedIntervalOverride>? nonRevokedIntervalOverrides,
  });

  Map<String, ObjectHandle> createRevocationRegistryDefinition({
    required ObjectHandle credentialDefinition,
    required String credentialDefinitionId,
    required String issuerId,
    required String tag,
    required String revocationRegistryType,
    required int maximumCredentialNumber,
    String? tailsDirectoryPath,
  });

  ObjectHandle createOrUpdateRevocationState({
    required ObjectHandle revocationRegistryDefinition,
    required ObjectHandle revocationStatusList,
    required int revocationRegistryIndex,
    required String tailsPath,
    ObjectHandle? oldRevocationState,
    ObjectHandle? oldRevocationStatusList,
  });

  ObjectHandle createRevocationStatusList({
    required ObjectHandle credentialDefinition,
    required String revocationRegistryDefinitionId,
    required ObjectHandle revocationRegistryDefinition,
    required ObjectHandle revocationRegistryDefinitionPrivate,
    required String issuerId,
    required bool issuanceByDefault,
    int? timestamp,
  });

  ObjectHandle updateRevocationStatusListTimestampOnly({
    required int timestamp,
    required ObjectHandle currentRevocationStatusList,
  });

  ObjectHandle updateRevocationStatusList({
    required ObjectHandle credentialDefinition,
    required ObjectHandle revocationRegistryDefinition,
    required ObjectHandle revocationRegistryDefinitionPrivate,
    required ObjectHandle currentRevocationStatusList,
    List<int>? issued,
    List<int>? revoked,
    int? timestamp,
  });

  String credentialGetAttribute({
    required ObjectHandle objectHandle,
    required String name,
  });

  String revocationRegistryDefinitionGetAttribute({
    required ObjectHandle objectHandle,
    required String name,
  });

  AnoncredsResult<PresentationRequest> presentationRequestFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<RevocationRegistryDefinition> revocationRegistryDefinitionFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<RevocationRegistry> revocationRegistryFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<RevocationStatusList> revocationStatusListFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<Presentation> presentationFromJson(Map<String, dynamic> json);

  AnoncredsResult<CredentialOffer> credentialOfferFromJson(Map<String, dynamic> json);

  AnoncredsResult<Schema> schemaFromJson(Map<String, dynamic> json);

  AnoncredsResult<CredentialRequest> credentialRequestFromJson(Map<String, dynamic> json);

  AnoncredsResult<CredentialRequestMetadata> credentialRequestMetadataFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<Credential> credentialFromJson(Map<String, dynamic> json);

  AnoncredsResult<RevocationRegistryDefinitionPrivate>
      revocationRegistryDefinitionPrivateFromJson(Map<String, dynamic> json);

  AnoncredsResult<CredentialRevocationState> revocationStateFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<CredentialDefinition> credentialDefinitionFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<CredentialDefinitionPrivate> credentialDefinitionPrivateFromJson(
      Map<String, dynamic> json);

  AnoncredsResult<KeyCorrectnessProof> keyCorrectnessProofFromJson(
      Map<String, dynamic> json);

  void objectFree(ObjectHandle handle);

  AnoncredsResult<String> objectGetJson(ObjectHandle handle);

  AnoncredsResult<String> objectGetTypeName(ObjectHandle handle);

  ObjectHandle createW3cCredential({
    required ObjectHandle credentialDefinition,
    required ObjectHandle credentialDefinitionPrivate,
    required ObjectHandle credentialOffer,
    required ObjectHandle credentialRequest,
    required Map<String, String> attributeRawValues,
    NativeCredentialRevocationConfig? revocationConfiguration,
    String? w3cVersion,
  });

  ObjectHandle processW3cCredential({
    required ObjectHandle credential,
    required ObjectHandle credentialRequestMetadata,
    required String linkSecret,
    required ObjectHandle credentialDefinition,
    ObjectHandle? revocationRegistryDefinition,
  });

  ObjectHandle createW3cPresentation({
    required ObjectHandle presentationRequest,
    required List<NativeCredentialEntry> credentials,
    required List<NativeCredentialProve> credentialsProve,
    required String linkSecret,
    required Map<String, ObjectHandle> schemas,
    required Map<String, ObjectHandle> credentialDefinitions,
    String? w3cVersion,
  });

  bool verifyW3cPresentation({
    required ObjectHandle presentation,
    required ObjectHandle presentationRequest,
    required List<ObjectHandle> schemas,
    required List<String> schemaIds,
    required List<ObjectHandle> credentialDefinitions,
    required List<String> credentialDefinitionIds,
    List<ObjectHandle>? revocationRegistryDefinitions,
    List<String>? revocationRegistryDefinitionIds,
    List<ObjectHandle>? revocationStatusLists,
    List<NativeNonRevokedIntervalOverride>? nonRevokedIntervalOverrides,
  });

  AnoncredsResult<W3cPresentation> w3cPresentationFromJson(Map<String, dynamic> json);

  AnoncredsResult<W3cCredential> w3cCredentialFromJson(Map<String, dynamic> json);

  ObjectHandle credentialToW3c({
    required ObjectHandle objectHandle,
    required String issuerId,
    String? w3cVersion,
  });

  ObjectHandle credentialFromW3c({
    required ObjectHandle objectHandle,
  });

  ObjectHandle w3cCredentialGetIntegrityProofDetails({
    required ObjectHandle objectHandle,
  });

  String w3cCredentialProofGetAttribute({
    required ObjectHandle objectHandle,
    required String name,
  });
}

class Anoncreds implements IAnoncreds {
  @override
  ObjectHandle createCredential(
      {required ObjectHandle credentialDefinition,
      required ObjectHandle credentialDefinitionPrivate,
      required ObjectHandle credentialOffer,
      required ObjectHandle credentialRequest,
      required Map<String, String> attributeRawValues,
      Map<String, String>? attributeEncodedValues,
      NativeCredentialRevocationConfig? revocationConfiguration}) {
    // TODO: implement createCredential
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<CredentialDefinitionCreation> createCredentialDefinition({
    required String schemaId,
    required ObjectHandle schemaHandle,
    required String tag,
    required String issuerId,
    required SignatureType signatureType,
    required bool supportRevocation,
  }) {
    Pointer<Int64> credDefPtr = calloc<Int64>();
    Pointer<Int64> credDefPvtPtr = calloc<Int64>();
    Pointer<Int64> keyProofPtr = calloc<Int64>();

    Pointer<Utf8> schemaIdPtr = nullptr;
    Pointer<Utf8> tagPtr = nullptr;
    Pointer<Utf8> issuerIdPtr = nullptr;
    Pointer<Utf8> sigTypePtr = nullptr;

    try {
      schemaIdPtr = schemaId.toNativeUtf8();
      tagPtr = tag.toNativeUtf8();
      issuerIdPtr = issuerId.toNativeUtf8();
      sigTypePtr = signatureType.value.toNativeUtf8();

      final initialResult = nativeAnoncredsCreateCredentialDefinition(
        schemaIdPtr,
        schemaHandle.toInt(),
        tagPtr,
        issuerIdPtr,
        sigTypePtr,
        boolToInt(supportRevocation),
        credDefPtr,
        credDefPvtPtr,
        keyProofPtr,
      );

      final errorCode = ErrorCode.fromInt(initialResult);

      final value = CredentialDefinitionCreation(
        CredentialDefinition(credDefPtr.value),
        CredentialDefinitionPrivate(credDefPvtPtr.value),
        KeyCorrectnessProof(keyProofPtr.value),
      );

      return AnoncredsResult(errorCode, value);
    } finally {
      freePointer(credDefPtr);
      freePointer(credDefPvtPtr);
      freePointer(keyProofPtr);
      freePointer(schemaIdPtr);
      freePointer(tagPtr);
      freePointer(issuerIdPtr);
      freePointer(sigTypePtr);
    }
  }

  @override
  ObjectHandle createCredentialOffer(
      {required String schemaId,
      required String credentialDefinitionId,
      required ObjectHandle keyCorrectnessProof}) {
    // TODO: implement createCredentialOffer
    throw UnimplementedError();
  }

  @override
  Map<String, ObjectHandle> createCredentialRequest(
      {String? entropy,
      String? proverDid,
      required ObjectHandle credentialDefinition,
      required String linkSecret,
      required String linkSecretId,
      required ObjectHandle credentialOffer}) {
    // TODO: implement createCredentialRequest
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<String> createLinkSecret() {
    Pointer<Pointer<Utf8>> resultPtrPointer = calloc<Pointer<Utf8>>();
    try {
      final result = nativeAnoncredsCreateLinkSecret(resultPtrPointer);
      final errorCode = ErrorCode.fromInt(result);
      final value =
          (errorCode == ErrorCode.success) ? resultPtrPointer.value.toDartString() : "";
      return AnoncredsResult<String>(errorCode, value);
    } finally {
      freeDoublePointer(resultPtrPointer);
    }
  }

  @override
  ObjectHandle createOrUpdateRevocationState(
      {required ObjectHandle revocationRegistryDefinition,
      required ObjectHandle revocationStatusList,
      required int revocationRegistryIndex,
      required String tailsPath,
      ObjectHandle? oldRevocationState,
      ObjectHandle? oldRevocationStatusList}) {
    // TODO: implement createOrUpdateRevocationState
    throw UnimplementedError();
  }

  @override
  ObjectHandle createPresentation(
      {required ObjectHandle presentationRequest,
      required List<NativeCredentialEntry> credentials,
      required List<NativeCredentialProve> credentialsProve,
      required Map<String, String> selfAttest,
      required String linkSecret,
      required Map<String, ObjectHandle> schemas,
      required Map<String, ObjectHandle> credentialDefinitions}) {
    // TODO: implement createPresentation
    throw UnimplementedError();
  }

  @override
  Map<String, ObjectHandle> createRevocationRegistryDefinition(
      {required ObjectHandle credentialDefinition,
      required String credentialDefinitionId,
      required String issuerId,
      required String tag,
      required String revocationRegistryType,
      required int maximumCredentialNumber,
      String? tailsDirectoryPath}) {
    // TODO: implement createRevocationRegistryDefinition
    throw UnimplementedError();
  }

  @override
  ObjectHandle createRevocationStatusList(
      {required ObjectHandle credentialDefinition,
      required String revocationRegistryDefinitionId,
      required ObjectHandle revocationRegistryDefinition,
      required ObjectHandle revocationRegistryDefinitionPrivate,
      required String issuerId,
      required bool issuanceByDefault,
      int? timestamp}) {
    // TODO: implement createRevocationStatusList
    throw UnimplementedError();
  }

  @override
  ObjectHandle createSchema(
      {required String name,
      required String version,
      required String issuerId,
      required List<String> attributeNames}) {
    // TODO: implement createSchema
    throw UnimplementedError();
  }

  @override
  ObjectHandle createW3cCredential(
      {required ObjectHandle credentialDefinition,
      required ObjectHandle credentialDefinitionPrivate,
      required ObjectHandle credentialOffer,
      required ObjectHandle credentialRequest,
      required Map<String, String> attributeRawValues,
      NativeCredentialRevocationConfig? revocationConfiguration,
      String? w3cVersion}) {
    // TODO: implement createW3cCredential
    throw UnimplementedError();
  }

  @override
  ObjectHandle createW3cPresentation(
      {required ObjectHandle presentationRequest,
      required List<NativeCredentialEntry> credentials,
      required List<NativeCredentialProve> credentialsProve,
      required String linkSecret,
      required Map<String, ObjectHandle> schemas,
      required Map<String, ObjectHandle> credentialDefinitions,
      String? w3cVersion}) {
    // TODO: implement createW3cPresentation
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<CredentialDefinition> credentialDefinitionFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsCredentialDefinitionFromJson);

    return AnoncredsResult(result.errorCode, CredentialDefinition(result.value));
  }

  @override
  AnoncredsResult<CredentialDefinitionPrivate> credentialDefinitionPrivateFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsCredentialDefinitionPrivateFromJson);

    return AnoncredsResult(result.errorCode, CredentialDefinitionPrivate(result.value));
  }

  @override
  AnoncredsResult<Credential> credentialFromJson(Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsCredentialFromJson);

    return AnoncredsResult(result.errorCode, Credential(result.value));
  }

  @override
  ObjectHandle credentialFromW3c({required ObjectHandle objectHandle}) {
    // TODO: implement credentialFromW3c
    throw UnimplementedError();
  }

  @override
  String credentialGetAttribute(
      {required ObjectHandle objectHandle, required String name}) {
    // TODO: implement credentialGetAttribute
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<CredentialOffer> credentialOfferFromJson(Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsCredentialOfferFromJson);

    return AnoncredsResult(result.errorCode, CredentialOffer(result.value));
  }

  @override
  AnoncredsResult<CredentialRequest> credentialRequestFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsCredentialRequestFromJson);

    return AnoncredsResult(result.errorCode, CredentialRequest(result.value));
  }

  @override
  AnoncredsResult<CredentialRequestMetadata> credentialRequestMetadataFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsCredentialRequestMetadataFromJson);

    return AnoncredsResult(result.errorCode, CredentialRequestMetadata(result.value));
  }

  @override
  ObjectHandle credentialToW3c(
      {required ObjectHandle objectHandle,
      required String issuerId,
      String? w3cVersion}) {
    // TODO: implement credentialToW3c
    throw UnimplementedError();
  }

  @override
  List<String> encodeCredentialAttributes({required List<String> attributeRawValues}) {
    // TODO: implement encodeCredentialAttributes
    throw UnimplementedError();
  }

  @override
  String generateNonce() {
    // TODO: implement generateNonce
    throw UnimplementedError();
  }

  @override
  String getCurrentError() {
    // TODO: implement getCurrentError
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<KeyCorrectnessProof> keyCorrectnessProofFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsKeyCorrectnessProofFromJson);

    return AnoncredsResult(result.errorCode, KeyCorrectnessProof(result.value));
  }

  @override
  void objectFree(ObjectHandle handle) {
    nativeAnoncredsObjectFree(handle.handle);
  }

  @override
  AnoncredsResult<String> objectGetJson(ObjectHandle handle) {
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

  @override
  AnoncredsResult<String> objectGetTypeName(ObjectHandle handle) {
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

  @override
  AnoncredsResult<Presentation> presentationFromJson(Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsPresentationFromJson);

    return AnoncredsResult(result.errorCode, Presentation(result.value));
  }

  @override
  AnoncredsResult<PresentationRequest> presentationRequestFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsPresentationRequestFromJson);

    return AnoncredsResult(result.errorCode, PresentationRequest(result.value));
  }

  @override
  ObjectHandle processCredential(
      {required ObjectHandle credential,
      required ObjectHandle credentialRequestMetadata,
      required String linkSecret,
      required ObjectHandle credentialDefinition,
      ObjectHandle? revocationRegistryDefinition}) {
    // TODO: implement processCredential
    throw UnimplementedError();
  }

  @override
  ObjectHandle processW3cCredential(
      {required ObjectHandle credential,
      required ObjectHandle credentialRequestMetadata,
      required String linkSecret,
      required ObjectHandle credentialDefinition,
      ObjectHandle? revocationRegistryDefinition}) {
    // TODO: implement processW3cCredential
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<RevocationRegistryDefinition> revocationRegistryDefinitionFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsRevocationRegistryDefinitionFromJson);

    return AnoncredsResult(result.errorCode, RevocationRegistryDefinition(result.value));
  }

  @override
  String revocationRegistryDefinitionGetAttribute(
      {required ObjectHandle objectHandle, required String name}) {
    // TODO: implement revocationRegistryDefinitionGetAttribute
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<RevocationRegistryDefinitionPrivate>
      revocationRegistryDefinitionPrivateFromJson(Map<String, dynamic> json) {
    final result =
        _fromJson(json, nativeAnoncredsRevocationRegistryDefinitionPrivateFromJson);

    return AnoncredsResult(
        result.errorCode, RevocationRegistryDefinitionPrivate(result.value));
  }

  @override
  AnoncredsResult<RevocationRegistry> revocationRegistryFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsRevocationRegistryFromJson);

    return AnoncredsResult(result.errorCode, RevocationRegistry(result.value));
  }

  @override
  AnoncredsResult<CredentialRevocationState> revocationStateFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsRevocationStateFromJson);

    return AnoncredsResult(result.errorCode, CredentialRevocationState(result.value));
  }

  @override
  AnoncredsResult<RevocationStatusList> revocationStatusListFromJson(
      Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsRevocationStateFromJson);

    return AnoncredsResult(result.errorCode, RevocationStatusList(result.value));
  }

  @override
  AnoncredsResult<Schema> schemaFromJson(Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsSchemaFromJson);

    return AnoncredsResult(result.errorCode, Schema(result.value));
  }

  @override
  void setDefaultLogger() {
    // TODO: implement setDefaultLogger
  }

  @override
  ObjectHandle updateRevocationStatusList(
      {required ObjectHandle credentialDefinition,
      required ObjectHandle revocationRegistryDefinition,
      required ObjectHandle revocationRegistryDefinitionPrivate,
      required ObjectHandle currentRevocationStatusList,
      List<int>? issued,
      List<int>? revoked,
      int? timestamp}) {
    // TODO: implement updateRevocationStatusList
    throw UnimplementedError();
  }

  @override
  ObjectHandle updateRevocationStatusListTimestampOnly(
      {required int timestamp, required ObjectHandle currentRevocationStatusList}) {
    // TODO: implement updateRevocationStatusListTimestampOnly
    throw UnimplementedError();
  }

  @override
  bool verifyPresentation(
      {required ObjectHandle presentation,
      required ObjectHandle presentationRequest,
      required List<ObjectHandle> schemas,
      required List<String> schemaIds,
      required List<ObjectHandle> credentialDefinitions,
      required List<String> credentialDefinitionIds,
      List<ObjectHandle>? revocationRegistryDefinitions,
      List<String>? revocationRegistryDefinitionIds,
      List<ObjectHandle>? revocationStatusLists,
      List<NativeNonRevokedIntervalOverride>? nonRevokedIntervalOverrides}) {
    // TODO: implement verifyPresentation
    throw UnimplementedError();
  }

  @override
  bool verifyW3cPresentation(
      {required ObjectHandle presentation,
      required ObjectHandle presentationRequest,
      required List<ObjectHandle> schemas,
      required List<String> schemaIds,
      required List<ObjectHandle> credentialDefinitions,
      required List<String> credentialDefinitionIds,
      List<ObjectHandle>? revocationRegistryDefinitions,
      List<String>? revocationRegistryDefinitionIds,
      List<ObjectHandle>? revocationStatusLists,
      List<NativeNonRevokedIntervalOverride>? nonRevokedIntervalOverrides}) {
    // TODO: implement verifyW3cPresentation
    throw UnimplementedError();
  }

  @override
  String version() {
    Pointer<Utf8> resultPointer = nullptr;

    try {
      resultPointer = nativeAnoncredsVersion();
      return resultPointer.toDartString();
    } finally {
      freePointer(resultPointer);
    }
  }

  @override
  AnoncredsResult<W3cCredential> w3cCredentialFromJson(Map<String, dynamic> json) {
    final result = _fromJson(json, nativeAnoncredsW3cCredentialFromJson);

    return AnoncredsResult(result.errorCode, W3cCredential(result.value));
  }

  @override
  ObjectHandle w3cCredentialGetIntegrityProofDetails(
      {required ObjectHandle objectHandle}) {
    // TODO: implement w3cCredentialGetIntegrityProofDetails
    throw UnimplementedError();
  }

  @override
  String w3cCredentialProofGetAttribute(
      {required ObjectHandle objectHandle, required String name}) {
    // TODO: implement w3cCredentialProofGetAttribute
    throw UnimplementedError();
  }

  @override
  AnoncredsResult<W3cPresentation> w3cPresentationFromJson(Map<String, dynamic> json) {
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
}
