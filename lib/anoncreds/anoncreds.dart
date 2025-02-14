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

  Map<String, ObjectHandle> createCredentialDefinition({
    required String schemaId,
    required ObjectHandle schema,
    required String tag,
    required String issuerId,
    required String signatureType,
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

  String createLinkSecret();

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

  ObjectHandle presentationRequestFromJson({
    required String json,
  });

  ObjectHandle revocationRegistryDefinitionFromJson({
    required String json,
  });

  ObjectHandle revocationRegistryFromJson({
    required String json,
  });

  ObjectHandle revocationStatusListFromJson({
    required String json,
  });

  ObjectHandle presentationFromJson({
    required String json,
  });

  ObjectHandle credentialOfferFromJson({
    required String json,
  });

  ObjectHandle schemaFromJson({
    required String json,
  });

  ObjectHandle credentialRequestFromJson({
    required String json,
  });

  ObjectHandle credentialRequestMetadataFromJson({
    required String json,
  });

  ObjectHandle credentialFromJson({
    required String json,
  });

  ObjectHandle revocationRegistryDefinitionPrivateFromJson({
    required String json,
  });

  ObjectHandle revocationStateFromJson({
    required String json,
  });

  ObjectHandle credentialDefinitionFromJson({
    required String json,
  });

  ObjectHandle credentialDefinitionPrivateFromJson({
    required String json,
  });

  ObjectHandle keyCorrectnessProofFromJson({
    required String json,
  });

  String getJson({
    required ObjectHandle objectHandle,
  });

  String getTypeName({
    required ObjectHandle objectHandle,
  });

  void objectFree({
    required ObjectHandle objectHandle,
  });

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

  ObjectHandle w3cPresentationFromJson({
    required String json,
  });

  ObjectHandle w3cCredentialFromJson({
    required String json,
  });

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
  Map<String, ObjectHandle> createCredentialDefinition(
      {required String schemaId,
      required ObjectHandle schema,
      required String tag,
      required String issuerId,
      required String signatureType,
      required bool supportRevocation}) {
    // TODO: implement createCredentialDefinition
    throw UnimplementedError();
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
  String createLinkSecret() {
    // TODO: implement createLinkSecret
    throw UnimplementedError();
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
  ObjectHandle credentialDefinitionFromJson({required String json}) {
    // TODO: implement credentialDefinitionFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle credentialDefinitionPrivateFromJson({required String json}) {
    // TODO: implement credentialDefinitionPrivateFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle credentialFromJson({required String json}) {
    // TODO: implement credentialFromJson
    throw UnimplementedError();
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
  ObjectHandle credentialOfferFromJson({required String json}) {
    // TODO: implement credentialOfferFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle credentialRequestFromJson({required String json}) {
    // TODO: implement credentialRequestFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle credentialRequestMetadataFromJson({required String json}) {
    // TODO: implement credentialRequestMetadataFromJson
    throw UnimplementedError();
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
  String getJson({required ObjectHandle objectHandle}) {
    // TODO: implement getJson
    throw UnimplementedError();
  }

  @override
  String getTypeName({required ObjectHandle objectHandle}) {
    // TODO: implement getTypeName
    throw UnimplementedError();
  }

  @override
  ObjectHandle keyCorrectnessProofFromJson({required String json}) {
    // TODO: implement keyCorrectnessProofFromJson
    throw UnimplementedError();
  }

  @override
  void objectFree({required ObjectHandle objectHandle}) {
    // TODO: implement objectFree
  }

  @override
  ObjectHandle presentationFromJson({required String json}) {
    // TODO: implement presentationFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle presentationRequestFromJson({required String json}) {
    // TODO: implement presentationRequestFromJson
    throw UnimplementedError();
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
  ObjectHandle revocationRegistryDefinitionFromJson({required String json}) {
    // TODO: implement revocationRegistryDefinitionFromJson
    throw UnimplementedError();
  }

  @override
  String revocationRegistryDefinitionGetAttribute(
      {required ObjectHandle objectHandle, required String name}) {
    // TODO: implement revocationRegistryDefinitionGetAttribute
    throw UnimplementedError();
  }

  @override
  ObjectHandle revocationRegistryDefinitionPrivateFromJson({required String json}) {
    // TODO: implement revocationRegistryDefinitionPrivateFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle revocationRegistryFromJson({required String json}) {
    // TODO: implement revocationRegistryFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle revocationStateFromJson({required String json}) {
    // TODO: implement revocationStateFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle revocationStatusListFromJson({required String json}) {
    // TODO: implement revocationStatusListFromJson
    throw UnimplementedError();
  }

  @override
  ObjectHandle schemaFromJson({required String json}) {
    // TODO: implement schemaFromJson
    throw UnimplementedError();
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
    // TODO: implement version
    throw UnimplementedError();
  }

  @override
  ObjectHandle w3cCredentialFromJson({required String json}) {
    // TODO: implement w3cCredentialFromJson
    throw UnimplementedError();
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
  ObjectHandle w3cPresentationFromJson({required String json}) {
    // TODO: implement w3cPresentationFromJson
    throw UnimplementedError();
  }
}
