import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds_object.dart';
import '../register.dart';
import 'revocation_registry_definition.dart';
import 'revocation_status_list.dart';
import '../object_handle.dart';

class CreateRevocationStateOptions {
  final RevocationRegistryDefinition revocationRegistryDefinition;
  final RevocationStatusList revocationStatusList;
  final int revocationRegistryIndex;
  final String tailsPath;
  final RevocationStatusList? oldRevocationStatusList;
  final CredentialRevocationState? oldRevocationState;

  CreateRevocationStateOptions({
    required this.revocationRegistryDefinition,
    required this.revocationStatusList,
    required this.revocationRegistryIndex,
    required this.tailsPath,
    this.oldRevocationStatusList,
    this.oldRevocationState,
  });
}

class UpdateRevocationStateOptions {
  final RevocationRegistryDefinition revocationRegistryDefinition;
  final RevocationStatusList revocationStatusList;
  final int revocationRegistryIndex;
  final String tailsPath;
  final RevocationStatusList oldRevocationStatusList;
  final CredentialRevocationState oldRevocationState;

  UpdateRevocationStateOptions({
    required this.revocationRegistryDefinition,
    required this.revocationStatusList,
    required this.revocationRegistryIndex,
    required this.tailsPath,
    required this.oldRevocationStatusList,
    required this.oldRevocationState,
  });
}

class CredentialRevocationState extends AnoncredsObject {
  CredentialRevocationState(super.handle);

  factory CredentialRevocationState.create(CreateRevocationStateOptions options) {
    int credentialRevocationStateHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle revocationRegistryDefinition =
          options.revocationRegistryDefinition.handle;
      ObjectHandle revocationStatusList = options.revocationStatusList.handle;

      credentialRevocationStateHandle = anoncreds
          .createOrUpdateRevocationState(
            revocationRegistryDefinition: revocationRegistryDefinition,
            revocationStatusList: revocationStatusList,
            revocationRegistryIndex: options.revocationRegistryIndex,
            tailsPath: options.tailsPath,
            oldRevocationStatusList: options.oldRevocationStatusList?.handle,
            oldRevocationState: options.oldRevocationState?.handle,
          )
          .handle;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return CredentialRevocationState(credentialRevocationStateHandle);
  }

  factory CredentialRevocationState.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.revocationStateFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential revocation state from json: $e");
    }
  }

  void update(UpdateRevocationStateOptions options) {
    anoncreds.createOrUpdateRevocationState(
      revocationRegistryDefinition: options.revocationRegistryDefinition.handle,
      revocationStatusList: options.revocationStatusList.handle,
      revocationRegistryIndex: options.revocationRegistryIndex,
      tailsPath: options.tailsPath,
      oldRevocationStatusList: options.oldRevocationStatusList.handle,
      oldRevocationState: options.oldRevocationState.handle,
    );
  }
}
