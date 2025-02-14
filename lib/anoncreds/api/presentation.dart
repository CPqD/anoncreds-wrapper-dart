import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds.dart';
import 'revocation_registry.dart';
import '../object_handle.dart';
import '../anoncreds_object.dart';
import '../register.dart';
import 'credential.dart';
import 'credential_definition.dart';
import 'credential_revocation_state.dart';
import 'presentation_request.dart';
import 'revocation_registry_definition.dart';
import 'revocation_status_list.dart';
import 'schema.dart';
import 'utils.dart';

class NonRevokedIntervalOverride {
  final String revocationRegistryDefinitionId;
  final int requestedFromTimestamp;
  final int overrideRevocationStatusListTimestamp;

  NonRevokedIntervalOverride({
    required this.revocationRegistryDefinitionId,
    required this.requestedFromTimestamp,
    required this.overrideRevocationStatusListTimestamp,
  });
}

class CredentialEntry {
  final dynamic credential;
  final int? timestamp;
  final dynamic revocationState;

  CredentialEntry({
    required this.credential,
    this.timestamp,
    this.revocationState,
  });
}

class CredentialProve {
  final int entryIndex;
  final String referent;
  final bool isPredicate;
  final bool reveal;

  CredentialProve({
    required this.entryIndex,
    required this.referent,
    required this.isPredicate,
    required this.reveal,
  });
}

class RevocationEntry {
  final int revocationRegistryDefinitionEntryIndex;
  final RevocationRegistry entry;
  final int timestamp;

  RevocationEntry({
    required this.revocationRegistryDefinitionEntryIndex,
    required this.entry,
    required this.timestamp,
  });
}

class CreatePresentationOptions {
  final dynamic presentationRequest;
  final List<CredentialEntry> credentials;
  final List<CredentialProve> credentialsProve;
  final Map<String, String> selfAttest;
  final String linkSecret;
  final Map<String, dynamic> schemas;
  final Map<String, dynamic> credentialDefinitions;

  CreatePresentationOptions({
    required this.presentationRequest,
    required this.credentials,
    required this.credentialsProve,
    required this.selfAttest,
    required this.linkSecret,
    required this.schemas,
    required this.credentialDefinitions,
  });
}

class VerifyPresentationOptions {
  final dynamic presentationRequest;
  final Map<String, dynamic> schemas;
  final Map<String, dynamic> credentialDefinitions;
  final Map<String, dynamic>? revocationRegistryDefinitions;
  final List<dynamic>? revocationStatusLists;
  final List<NonRevokedIntervalOverride>? nonRevokedIntervalOverrides;

  VerifyPresentationOptions({
    required this.presentationRequest,
    required this.schemas,
    required this.credentialDefinitions,
    this.revocationRegistryDefinitions,
    this.revocationStatusLists,
    this.nonRevokedIntervalOverrides,
  });
}

class Presentation extends AnoncredsObject {
  Presentation(super.handle);

  factory Presentation.create(CreatePresentationOptions options) {
    int presentationHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      int presentationRequest = options.presentationRequest is PresentationRequest
          ? options.presentationRequest.handle
          : pushToArray(PresentationRequest.fromJson(options.presentationRequest).handle,
              objectHandles);

      presentationHandle = anoncreds
              ?.createPresentation(
                presentationRequest: ObjectHandle(presentationRequest),
                credentials: options.credentials.map((item) {
                  return NativeCredentialEntry(
                    credential: item.credential is Credential
                        ? item.credential.handle
                        : pushToArray(
                            Credential.fromJson(item.credential).handle, objectHandles),
                    revocationState: item.revocationState is CredentialRevocationState
                        ? item.revocationState.handle
                        : item.revocationState != null
                            ? pushToArray(
                                CredentialRevocationState.fromJson(item.revocationState)
                                    .handle,
                                objectHandles)
                            : null,
                    timestamp: item.timestamp,
                  );
                }).toList(),
                credentialsProve: options.credentialsProve.map((item) {
                  return NativeCredentialProve(
                      entryIndex: item.entryIndex,
                      referent: item.referent,
                      isPredicate: item.isPredicate,
                      reveal: item.reveal);
                }).toList(),
                selfAttest: options.selfAttest,
                linkSecret: options.linkSecret,
                schemas: options.schemas.map((id, object) {
                  ObjectHandle objectHandle =
                      object is Schema ? object.handle : Schema.fromJson(object).handle;
                  return MapEntry(id, objectHandle);
                }),
                credentialDefinitions: options.credentialDefinitions.map((id, object) {
                  ObjectHandle objectHandle = object is CredentialDefinition
                      ? object.handle
                      : CredentialDefinition.fromJson(object).handle;
                  return MapEntry(id, objectHandle);
                }),
              )
              .handle ??
          0;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return Presentation(presentationHandle);
  }

  factory Presentation.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsPresentationFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get presentation from json: $e");
    }
  }

  bool verify(VerifyPresentationOptions options) {
    List<dynamic> schemas = options.schemas.values.toList();
    List<String> schemaIds = options.schemas.keys.toList();

    List<dynamic> credentialDefinitions = options.credentialDefinitions.values.toList();
    List<String> credentialDefinitionIds = options.credentialDefinitions.keys.toList();

    List<dynamic>? revocationRegistryDefinitions =
        options.revocationRegistryDefinitions?.values.toList();
    List<String>? revocationRegistryDefinitionIds =
        options.revocationRegistryDefinitions?.keys.toList();

    bool verified;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle presentationRequest =
          options.presentationRequest is PresentationRequest
              ? options.presentationRequest.handle
              : pushToArray(
                  PresentationRequest.fromJson(options.presentationRequest).handle,
                  objectHandles);

      verified = anoncreds?.verifyPresentation(
            presentation: handle,
            presentationRequest: presentationRequest,
            schemas: schemas.map((o) {
              return o is Schema ? o.handle : Schema.fromJson(o).handle;
            }).toList(),
            schemaIds: schemaIds,
            credentialDefinitions: credentialDefinitions.map((o) {
              return o is CredentialDefinition
                  ? o.handle
                  : CredentialDefinition.fromJson(o).handle;
            }).toList(),
            credentialDefinitionIds: credentialDefinitionIds,
            revocationRegistryDefinitions: revocationRegistryDefinitions?.map((o) {
              return o is RevocationRegistryDefinition
                  ? o.handle
                  : RevocationRegistryDefinition.fromJson(o).handle;
            }).toList(),
            revocationRegistryDefinitionIds: revocationRegistryDefinitionIds,
            revocationStatusLists: options.revocationStatusLists?.map((o) {
              return o is RevocationStatusList
                  ? o.handle
                  : RevocationStatusList.fromJson(o).handle;
            }).toList(),
            nonRevokedIntervalOverrides: options.nonRevokedIntervalOverrides?.map((item) {
              return NativeNonRevokedIntervalOverride(
                revocationRegistryDefinitionId: item.revocationRegistryDefinitionId,
                requestedFromTimestamp: item.requestedFromTimestamp,
                overrideRevocationStatusListTimestamp:
                    item.overrideRevocationStatusListTimestamp,
              );
            }).toList(),
          ) ??
          false;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return verified;
  }
}
