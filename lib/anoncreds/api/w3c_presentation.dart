import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds.dart';
import 'presentation.dart';
import '../object_handle.dart';
import '../anoncreds_object.dart';
import '../register.dart';
import 'credential_definition.dart';
import 'credential_revocation_state.dart';
import 'presentation_request.dart';
import 'revocation_registry_definition.dart';
import 'revocation_status_list.dart';
import 'schema.dart';
import 'w3c_credential.dart';
import 'utils.dart';

class W3cCredentialEntry {
  final dynamic credential;
  final int? timestamp;
  final dynamic revocationState;

  W3cCredentialEntry({
    required this.credential,
    this.timestamp,
    this.revocationState,
  });
}

class CreateW3cPresentationOptions {
  final dynamic presentationRequest;
  final List<W3cCredentialEntry> credentials;
  final List<CredentialProve> credentialsProve;
  final String linkSecret;
  final Map<String, dynamic> schemas;
  final Map<String, dynamic> credentialDefinitions;

  CreateW3cPresentationOptions({
    required this.presentationRequest,
    required this.credentials,
    required this.credentialsProve,
    required this.linkSecret,
    required this.schemas,
    required this.credentialDefinitions,
  });
}

class VerifyW3cPresentationOptions {
  final dynamic presentationRequest;
  final Map<String, dynamic> schemas;
  final Map<String, dynamic> credentialDefinitions;
  final Map<String, dynamic>? revocationRegistryDefinitions;
  final List<dynamic>? revocationStatusLists;
  final List<NonRevokedIntervalOverride>? nonRevokedIntervalOverrides;

  VerifyW3cPresentationOptions({
    required this.presentationRequest,
    required this.schemas,
    required this.credentialDefinitions,
    this.revocationRegistryDefinitions,
    this.revocationStatusLists,
    this.nonRevokedIntervalOverrides,
  });
}

class W3cPresentation extends AnoncredsObject {
  W3cPresentation(super.handle);

  factory W3cPresentation.create(CreateW3cPresentationOptions options) {
    int presentationHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      ObjectHandle presentationRequest =
          options.presentationRequest is PresentationRequest
              ? options.presentationRequest.handle
              : pushToArray(
                  PresentationRequest.fromJson(options.presentationRequest).handle,
                  objectHandles);

      presentationHandle = anoncreds
              ?.createW3cPresentation(
                presentationRequest: presentationRequest,
                credentials: options.credentials.map((item) {
                  return NativeCredentialEntry(
                    credential: item.credential is W3cCredential
                        ? item.credential.handle
                        : pushToArray(W3cCredential.fromJson(item.credential).handle,
                            objectHandles),
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

    return W3cPresentation(presentationHandle);
  }

  factory W3cPresentation.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsW3cPresentationFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get W3C presentation from json: $e");
    }
  }

  bool verify(VerifyW3cPresentationOptions options) {
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

      verified = anoncreds?.verifyW3cPresentation(
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
