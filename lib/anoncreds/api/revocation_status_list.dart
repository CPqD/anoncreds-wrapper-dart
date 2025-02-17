import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds_object.dart';
import '../object_handle.dart';
import '../register.dart';
import 'credential_definition.dart';
import 'revocation_registry_definition.dart';
import 'revocation_registry_definition_private.dart';
import 'utils.dart';

class CreateRevocationStatusListOptions {
  final dynamic credentialDefinition;
  final String revocationRegistryDefinitionId;
  final dynamic revocationRegistryDefinition;
  final dynamic revocationRegistryDefinitionPrivate;
  final String issuerId;
  final bool issuanceByDefault;
  final int? timestamp;

  CreateRevocationStatusListOptions({
    required this.credentialDefinition,
    required this.revocationRegistryDefinitionId,
    required this.revocationRegistryDefinition,
    required this.revocationRegistryDefinitionPrivate,
    required this.issuerId,
    required this.issuanceByDefault,
    this.timestamp,
  });
}

class UpdateRevocationStatusListTimestampOptions {
  final int timestamp;

  UpdateRevocationStatusListTimestampOptions({
    required this.timestamp,
  });
}

class UpdateRevocationStatusListOptions {
  final dynamic credentialDefinition;
  final dynamic revocationRegistryDefinition;
  final dynamic revocationRegistryDefinitionPrivate;
  final List<int>? issued;
  final List<int>? revoked;
  final int? timestamp;

  UpdateRevocationStatusListOptions({
    required this.credentialDefinition,
    required this.revocationRegistryDefinition,
    required this.revocationRegistryDefinitionPrivate,
    this.issued,
    this.revoked,
    this.timestamp,
  });
}

class RevocationStatusList extends AnoncredsObject {
  RevocationStatusList(super.handle);

  factory RevocationStatusList.create(CreateRevocationStatusListOptions options) {
    int revocationStatusListHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle credentialDefinition =
          options.credentialDefinition is CredentialDefinition
              ? options.credentialDefinition.handle
              : pushToArray(
                  CredentialDefinition.fromJson(options.credentialDefinition).handle,
                  objectHandles);

      ObjectHandle revocationRegistryDefinition = options.revocationRegistryDefinition
              is RevocationRegistryDefinition
          ? options.revocationRegistryDefinition.handle
          : pushToArray(
              RevocationRegistryDefinition.fromJson(options.revocationRegistryDefinition)
                  .handle,
              objectHandles);

      ObjectHandle revocationRegistryDefinitionPrivate = options
              .revocationRegistryDefinitionPrivate is RevocationRegistryDefinitionPrivate
          ? options.revocationRegistryDefinitionPrivate.handle
          : pushToArray(
              RevocationRegistryDefinitionPrivate.fromJson(
                      options.revocationRegistryDefinitionPrivate)
                  .handle,
              objectHandles);

      revocationStatusListHandle = anoncreds
          .createRevocationStatusList(
            credentialDefinition: credentialDefinition,
            revocationRegistryDefinitionId: options.revocationRegistryDefinitionId,
            revocationRegistryDefinition: revocationRegistryDefinition,
            revocationRegistryDefinitionPrivate: revocationRegistryDefinitionPrivate,
            issuerId: options.issuerId,
            issuanceByDefault: options.issuanceByDefault,
            timestamp: options.timestamp,
          )
          .handle;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return RevocationStatusList(revocationStatusListHandle);
  }

  factory RevocationStatusList.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.revocationStatusListFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get revocation status list from json: $e");
    }
  }

  void updateTimestamp(UpdateRevocationStatusListTimestampOptions options) {
    handle = anoncreds.updateRevocationStatusListTimestampOnly(
      timestamp: options.timestamp,
      currentRevocationStatusList: handle,
    );
  }

  void update(UpdateRevocationStatusListOptions options) {
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle credentialDefinition =
          options.credentialDefinition is CredentialDefinition
              ? options.credentialDefinition.handle
              : pushToArray(
                  CredentialDefinition.fromJson(options.credentialDefinition).handle,
                  objectHandles);

      ObjectHandle revocationRegistryDefinition = options.revocationRegistryDefinition
              is RevocationRegistryDefinition
          ? options.revocationRegistryDefinition.handle
          : pushToArray(
              RevocationRegistryDefinition.fromJson(options.revocationRegistryDefinition)
                  .handle,
              objectHandles);

      ObjectHandle revocationRegistryDefinitionPrivate = options
              .revocationRegistryDefinitionPrivate is RevocationRegistryDefinitionPrivate
          ? options.revocationRegistryDefinitionPrivate.handle
          : pushToArray(
              RevocationRegistryDefinitionPrivate.fromJson(
                      options.revocationRegistryDefinitionPrivate)
                  .handle,
              objectHandles);

      handle = anoncreds.updateRevocationStatusList(
        credentialDefinition: credentialDefinition,
        revocationRegistryDefinition: revocationRegistryDefinition,
        revocationRegistryDefinitionPrivate: revocationRegistryDefinitionPrivate,
        currentRevocationStatusList: handle,
        issued: options.issued,
        revoked: options.revoked,
        timestamp: options.timestamp,
      );
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }
  }
}
