import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds_object.dart';
import '../object_handle.dart';
import '../register.dart';
import 'credential.dart';
import 'credential_definition.dart';
import 'credential_definition_private.dart';
import 'credential_offer.dart';
import 'credential_request.dart';
import 'credential_request_metadata.dart';
import 'credential_revocation_config.dart';
import 'revocation_registry_definition.dart';
import 'utils.dart';

class CreateW3cCredentialOptions {
  final dynamic credentialDefinition;
  final dynamic credentialDefinitionPrivate;
  final dynamic credentialOffer;
  final dynamic credentialRequest;
  final Map<String, String> attributeRawValues;
  final String? revocationRegistryId;
  final CredentialRevocationConfig? revocationConfiguration;
  final dynamic revocationStatusList;
  final String? w3cVersion;

  CreateW3cCredentialOptions({
    required this.credentialDefinition,
    required this.credentialDefinitionPrivate,
    required this.credentialOffer,
    required this.credentialRequest,
    required this.attributeRawValues,
    this.revocationRegistryId,
    this.revocationConfiguration,
    this.revocationStatusList,
    this.w3cVersion,
  });
}

class ProcessW3cCredentialOptions {
  final dynamic credentialRequestMetadata;
  final String linkSecret;
  final dynamic credentialDefinition;
  final dynamic revocationRegistryDefinition;

  ProcessW3cCredentialOptions({
    required this.credentialRequestMetadata,
    required this.linkSecret,
    required this.credentialDefinition,
    this.revocationRegistryDefinition,
  });
}

class W3cCredentialFromLegacyOptions {
  final Credential credential;
  final String issuerId;
  final String? w3cVersion;

  W3cCredentialFromLegacyOptions({
    required this.credential,
    required this.issuerId,
    this.w3cVersion,
  });
}

class W3cCredential extends AnoncredsObject {
  ObjectHandle? proofDetails;

  W3cCredential(super.handle);

  factory W3cCredential.create(CreateW3cCredentialOptions options) {
    int credentialHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle credentialDefinition =
          options.credentialDefinition is CredentialDefinition
              ? options.credentialDefinition.handle
              : pushToArray(
                  CredentialDefinition.fromJson(options.credentialDefinition).handle,
                  objectHandles);

      ObjectHandle credentialDefinitionPrivate = options.credentialDefinitionPrivate
              is CredentialDefinitionPrivate
          ? options.credentialDefinitionPrivate.handle
          : pushToArray(
              CredentialDefinitionPrivate.fromJson(options.credentialDefinitionPrivate)
                  .handle,
              objectHandles);

      ObjectHandle credentialOffer = options.credentialOffer is CredentialOffer
          ? options.credentialOffer.handle
          : pushToArray(
              CredentialOffer.fromJson(options.credentialOffer).handle, objectHandles);

      ObjectHandle credentialRequest = options.credentialRequest is CredentialRequest
          ? options.credentialRequest.handle
          : pushToArray(CredentialRequest.fromJson(options.credentialRequest).handle,
              objectHandles);

      credentialHandle = anoncreds
          .createW3cCredential(
            credentialDefinition: credentialDefinition,
            credentialDefinitionPrivate: credentialDefinitionPrivate,
            credentialOffer: credentialOffer,
            credentialRequest: credentialRequest,
            attributeRawValues: options.attributeRawValues,
            revocationConfiguration: options.revocationConfiguration?.native,
            w3cVersion: options.w3cVersion,
          )
          .handle;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return W3cCredential(credentialHandle);
  }

  factory W3cCredential.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.w3cCredentialFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get W3C credential offer from json: $e");
    }
  }

  W3cCredential process(ProcessW3cCredentialOptions options) {
    ObjectHandle credentialHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle credentialDefinition =
          options.credentialDefinition is CredentialDefinition
              ? options.credentialDefinition.handle
              : pushToArray(
                  CredentialDefinition.fromJson(options.credentialDefinition).handle,
                  objectHandles);

      ObjectHandle credentialRequestMetadata =
          options.credentialRequestMetadata is CredentialRequestMetadata
              ? options.credentialRequestMetadata.handle
              : pushToArray(
                  CredentialRequestMetadata.fromJson(options.credentialRequestMetadata)
                      .handle,
                  objectHandles);

      ObjectHandle? revocationRegistryDefinition =
          options.revocationRegistryDefinition is RevocationRegistryDefinition
              ? options.revocationRegistryDefinition.handle
              : options.revocationRegistryDefinition != null
                  ? pushToArray(
                      RevocationRegistryDefinition.fromJson(
                              options.revocationRegistryDefinition)
                          .handle,
                      objectHandles)
                  : null;

      credentialHandle = anoncreds.processW3cCredential(
        credential: handle,
        credentialDefinition: credentialDefinition,
        credentialRequestMetadata: credentialRequestMetadata,
        linkSecret: options.linkSecret,
        revocationRegistryDefinition: revocationRegistryDefinition,
      );

      handle.clear();
      handle = credentialHandle;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return this;
  }

  ObjectHandle getProofDetails() {
    proofDetails ??=
        anoncreds.w3cCredentialGetIntegrityProofDetails(objectHandle: handle);
    return proofDetails!;
  }

  String get schemaId {
    return anoncreds.w3cCredentialProofGetAttribute(
        objectHandle: getProofDetails(), name: 'schema_id');
  }

  String get credentialDefinitionId {
    return anoncreds.w3cCredentialProofGetAttribute(
        objectHandle: getProofDetails(), name: 'cred_def_id');
  }

  String get revocationRegistryId {
    return anoncreds.w3cCredentialProofGetAttribute(
        objectHandle: getProofDetails(), name: 'rev_reg_id');
  }

  int? get revocationRegistryIndex {
    String index = anoncreds.w3cCredentialProofGetAttribute(
        objectHandle: getProofDetails(), name: 'rev_reg_index');
    return int.parse(index);
  }

  int? get timestamp {
    String timestamp = anoncreds.w3cCredentialProofGetAttribute(
        objectHandle: getProofDetails(), name: 'timestamp');
    return int.parse(timestamp);
  }

  Credential toLegacy() {
    return Credential(
      anoncreds.credentialFromW3c(objectHandle: handle).handle,
    );
  }

  factory W3cCredential.fromLegacy(W3cCredentialFromLegacyOptions options) {
    return W3cCredential(
      anoncreds
          .credentialToW3c(
            objectHandle: options.credential.handle,
            issuerId: options.issuerId,
            w3cVersion: options.w3cVersion,
          )
          .handle,
    );
  }
}
