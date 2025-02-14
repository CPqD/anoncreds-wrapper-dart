import 'dart:convert';

import '../types.dart';
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
  CredentialRevocationState(int handle) : super(handle);

  factory CredentialRevocationState.create(CreateRevocationStateOptions options) {
    int credentialRevocationStateHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle revocationRegistryDefinition =
          options.revocationRegistryDefinition.handle;
      ObjectHandle revocationStatusList = options.revocationStatusList.handle;

      credentialRevocationStateHandle = anoncreds
              ?.createOrUpdateRevocationState(
                revocationRegistryDefinition: revocationRegistryDefinition,
                revocationStatusList: revocationStatusList,
                revocationRegistryIndex: options.revocationRegistryIndex,
                tailsPath: options.tailsPath,
                oldRevocationStatusList: options.oldRevocationStatusList?.handle,
                oldRevocationState: options.oldRevocationState?.handle,
              )
              .handle ??
          0;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return CredentialRevocationState(credentialRevocationStateHandle);
  }

  factory CredentialRevocationState.fromJson(JsonObject json) {
    return CredentialRevocationState(
      anoncreds?.revocationStateFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }

  void update(UpdateRevocationStateOptions options) {
    handle = ObjectHandle(anoncreds
            ?.createOrUpdateRevocationState(
              revocationRegistryDefinition: options.revocationRegistryDefinition.handle,
              revocationStatusList: options.revocationStatusList.handle,
              revocationRegistryIndex: options.revocationRegistryIndex,
              tailsPath: options.tailsPath,
              oldRevocationStatusList: options.oldRevocationStatusList.handle,
              oldRevocationState: options.oldRevocationState.handle,
            )
            .handle ??
        0);
  }
}
