import 'dart:convert';

import '../object_handle.dart';
import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';
import 'credential_definition.dart';
import 'utils.dart';

class CreateRevocationRegistryDefinitionOptions {
  final dynamic credentialDefinition;
  final String credentialDefinitionId;
  final String tag;
  final String issuerId;
  final String revocationRegistryType;
  final int maximumCredentialNumber;
  final String? tailsDirectoryPath;

  CreateRevocationRegistryDefinitionOptions({
    required this.credentialDefinition,
    required this.credentialDefinitionId,
    required this.tag,
    required this.issuerId,
    required this.revocationRegistryType,
    required this.maximumCredentialNumber,
    this.tailsDirectoryPath,
  });
}

class RevocationRegistryDefinition extends AnoncredsObject {
  RevocationRegistryDefinition(int handle) : super(handle);

  factory RevocationRegistryDefinition.create(
      CreateRevocationRegistryDefinitionOptions options) {
    late Map<String, ObjectHandle> createReturnObj;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle credentialDefinition =
          options.credentialDefinition is CredentialDefinition
              ? options.credentialDefinition.handle
              : pushToArray(
                  CredentialDefinition.fromJson(options.credentialDefinition).handle,
                  objectHandles);

      createReturnObj = anoncreds?.createRevocationRegistryDefinition(
            credentialDefinition: credentialDefinition,
            credentialDefinitionId: options.credentialDefinitionId,
            tag: options.tag,
            issuerId: options.issuerId,
            revocationRegistryType: options.revocationRegistryType,
            maximumCredentialNumber: options.maximumCredentialNumber,
            tailsDirectoryPath: options.tailsDirectoryPath,
          ) ??
          {};
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return RevocationRegistryDefinition(
        createReturnObj['revocationRegistryDefinition']!.handle);
  }

  factory RevocationRegistryDefinition.fromJson(JsonObject json) {
    return RevocationRegistryDefinition(
      anoncreds?.revocationRegistryDefinitionFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }

  String getId() {
    return anoncreds?.revocationRegistryDefinitionGetAttribute(
          objectHandle: handle,
          name: 'id',
        ) ??
        '';
  }

  int getMaximumCredentialNumber() {
    return int.parse(
      anoncreds?.revocationRegistryDefinitionGetAttribute(
            objectHandle: handle,
            name: 'max_cred_num',
          ) ??
          '0',
    );
  }

  String getTailsHash() {
    return anoncreds?.revocationRegistryDefinitionGetAttribute(
          objectHandle: handle,
          name: 'tails_hash',
        ) ??
        '';
  }

  String getTailsLocation() {
    return anoncreds?.revocationRegistryDefinitionGetAttribute(
          objectHandle: handle,
          name: 'tails_location',
        ) ??
        '';
  }
}
