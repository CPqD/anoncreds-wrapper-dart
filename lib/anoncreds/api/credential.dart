import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import 'credential_request.dart';
import 'credential_request_metadata.dart';
import 'revocation_registry_definition.dart';
import 'w3c_credential.dart';
import 'utils.dart';
import '../anoncreds_object.dart';
import '../register.dart';
import 'credential_definition.dart';
import 'credential_definition_private.dart';
import 'credential_offer.dart';
import '../object_handle.dart';

class CreateCredentialOptions {
  final dynamic credentialDefinition;
  final dynamic credentialDefinitionPrivate;
  final dynamic credentialOffer;
  final dynamic credentialRequest;
  final Map<String, String> attributeRawValues;
  final Map<String, String>? attributeEncodedValues;
  final String? revocationRegistryId;
  final dynamic revocationConfiguration;
  final dynamic revocationStatusList;

  CreateCredentialOptions({
    required this.credentialDefinition,
    required this.credentialDefinitionPrivate,
    required this.credentialOffer,
    required this.credentialRequest,
    required this.attributeRawValues,
    this.attributeEncodedValues,
    this.revocationRegistryId,
    this.revocationConfiguration,
    this.revocationStatusList,
  });
}

class ProcessCredentialOptions {
  final dynamic credentialRequestMetadata;
  final String linkSecret;
  final dynamic credentialDefinition;
  final dynamic revocationRegistryDefinition;

  ProcessCredentialOptions({
    required this.credentialRequestMetadata,
    required this.linkSecret,
    required this.credentialDefinition,
    this.revocationRegistryDefinition,
  });
}

class CredentialToW3cOptions {
  final String issuerId;
  final String? w3cVersion;

  CredentialToW3cOptions({
    required this.issuerId,
    this.w3cVersion,
  });
}

class CredentialFromW3cOptions {
  final W3cCredential credential;

  CredentialFromW3cOptions({
    required this.credential,
  });
}

class Credential extends AnoncredsObject {
  Credential(super.handle);

  static Credential create(CreateCredentialOptions options) {
    int credential;
    List<ObjectHandle> objectHandles = [];
    try {
      int credentialDefinition = options.credentialDefinition is CredentialDefinition
          ? options.credentialDefinition.handle
          : pushToArray(
              CredentialDefinition.fromJson(options.credentialDefinition).handle,
              objectHandles);

      int credentialDefinitionPrivate = options.credentialDefinitionPrivate
              is CredentialDefinitionPrivate
          ? options.credentialDefinitionPrivate.handle
          : pushToArray(
              CredentialDefinitionPrivate.fromJson(options.credentialDefinitionPrivate)
                  .handle,
              objectHandles);

      int credentialOffer = options.credentialOffer is CredentialOffer
          ? options.credentialOffer.handle
          : pushToArray(
              CredentialOffer.fromJson(options.credentialOffer).handle, objectHandles);

      int credentialRequest = options.credentialRequest is CredentialRequest
          ? options.credentialRequest.handle
          : pushToArray(CredentialRequest.fromJson(options.credentialRequest).handle,
              objectHandles);

      credential = anoncreds!
          .createCredential(
            credentialDefinition: ObjectHandle(credentialDefinition),
            credentialDefinitionPrivate: ObjectHandle(credentialDefinitionPrivate),
            credentialOffer: ObjectHandle(credentialOffer),
            credentialRequest: ObjectHandle(credentialRequest),
            attributeRawValues: options.attributeRawValues,
            attributeEncodedValues: options.attributeEncodedValues,
            revocationConfiguration: options.revocationConfiguration?.native,
          )
          .handle;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }
    return Credential(credential);
  }

  factory Credential.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsCredentialFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential from json: $e");
    }
  }

  Credential process(ProcessCredentialOptions options) {
    ObjectHandle credential;
    List<ObjectHandle> objectHandles = [];
    try {
      int credentialDefinition = options.credentialDefinition is CredentialDefinition
          ? options.credentialDefinition.handle
          : pushToArray(
              CredentialDefinition.fromJson(options.credentialDefinition).handle,
              objectHandles);

      int credentialRequestMetadata =
          options.credentialRequestMetadata is CredentialRequestMetadata
              ? options.credentialRequestMetadata.handle
              : pushToArray(
                  CredentialRequestMetadata.fromJson(options.credentialRequestMetadata)
                      .handle,
                  objectHandles);

      int? revocationRegistryDefinition =
          options.revocationRegistryDefinition is RevocationRegistryDefinition
              ? options.revocationRegistryDefinition.handle
              : options.revocationRegistryDefinition != null
                  ? pushToArray(
                      RevocationRegistryDefinition.fromJson(
                              options.revocationRegistryDefinition)
                          .handle,
                      objectHandles)
                  : null;

      credential = anoncreds!.processCredential(
        credential: handle,
        credentialDefinition: ObjectHandle(credentialDefinition),
        credentialRequestMetadata: ObjectHandle(credentialRequestMetadata),
        linkSecret: options.linkSecret,
        revocationRegistryDefinition: ObjectHandle(revocationRegistryDefinition!),
      );

      handle.clear();
      handle = credential;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }
    return this;
  }

  String get schemaId {
    return anoncreds!.credentialGetAttribute(objectHandle: handle, name: 'schema_id');
  }

  String get credentialDefinitionId {
    return anoncreds!.credentialGetAttribute(objectHandle: handle, name: 'cred_def_id');
  }

  String get revocationRegistryId {
    return anoncreds!.credentialGetAttribute(objectHandle: handle, name: 'rev_reg_id');
  }

  int? get revocationRegistryIndex {
    String? index =
        anoncreds?.credentialGetAttribute(objectHandle: handle, name: 'rev_reg_index');
    return index != null ? int.parse(index) : null;
  }

  W3cCredential toW3c(CredentialToW3cOptions options) {
    return W3cCredential(
      anoncreds!
          .credentialToW3c(
            objectHandle: handle,
            issuerId: options.issuerId,
            w3cVersion: options.w3cVersion,
          )
          .handle,
    );
  }

  static Credential fromW3c(CredentialFromW3cOptions options) {
    return Credential(
        anoncreds!.credentialFromW3c(objectHandle: options.credential.handle).handle);
  }
}
