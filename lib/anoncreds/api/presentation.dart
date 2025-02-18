import 'package:anoncreds_wrapper_dart/anoncreds/api/credential.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds_object.dart';
import '../object_handle.dart';
import '../register.dart';
import 'credential_definition.dart';
import 'credential_revocation_state.dart';
import 'presentation_request.dart';
import 'revocation_registry.dart';
import 'revocation_registry_definition.dart';
import 'revocation_status_list.dart';
import 'schema.dart';

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

class DynamicCredentialEntry<T> {
  final T credential;
  final int? timestamp;
  final CredentialRevocationState? revocationState;

  DynamicCredentialEntry({
    required this.credential,
    this.timestamp,
    this.revocationState,
  });
}

class CredentialEntry extends DynamicCredentialEntry<Credential> {
  CredentialEntry({required super.credential, super.timestamp, super.revocationState});
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
  final List<DynamicCredentialEntry> credentials;
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

class DynamicVerifyPresentationOptions<T> {
  final T presentationRequest;
  final List<Schema> schemas;
  final List<CredentialDefinition> credentialDefinitions;
  final List<RevocationRegistryDefinition>? revocationRegistryDefinitions;
  final List<RevocationStatusList>? revocationStatusLists;
  final List<NonRevokedIntervalOverride>? nonRevokedIntervalOverrides;

  DynamicVerifyPresentationOptions({
    required this.presentationRequest,
    required this.schemas,
    required this.credentialDefinitions,
    this.revocationRegistryDefinitions,
    this.revocationStatusLists,
    this.nonRevokedIntervalOverrides,
  });
}

class VerifyPresentationOptions
    extends DynamicVerifyPresentationOptions<PresentationRequest> {
  VerifyPresentationOptions({
    required super.presentationRequest,
    required super.schemas,
    required super.credentialDefinitions,
    super.revocationRegistryDefinitions,
    super.revocationStatusLists,
    super.nonRevokedIntervalOverrides,
  });
}

class Presentation extends AnoncredsObject {
  Presentation(super.handle);

  factory Presentation.create(CreatePresentationOptions opts) {
    List<ObjectHandle> handlesToFree = [];

    PresentationRequest presentationRequest;
    List<CredentialEntry> credentials = [];
    List<String> selfAttestNames = [];
    List<String> selfAttestValues = [];
    List<Schema> schemas = [];
    List<String> schemasIDs = [];
    List<CredentialDefinition> credentialDefs = [];
    List<String> credentialDefIDs = [];

    try {
      if (opts.presentationRequest is PresentationRequest) {
        presentationRequest = opts.presentationRequest;
      } else {
        presentationRequest = PresentationRequest.fromDynamic(opts.presentationRequest);
        handlesToFree.add(presentationRequest.handle);
      }

      for (var credentialEntry in opts.credentials) {
        Credential credential;

        if (credentialEntry.credential is Credential) {
          credential = credentialEntry.credential;
        } else {
          credential = Credential.fromDynamic(credentialEntry.credential);
          handlesToFree.add(credential.handle);
        }

        credentials.add(CredentialEntry(
          credential: credential,
          revocationState: credentialEntry.revocationState,
          timestamp: credentialEntry.timestamp,
        ));
      }

      opts.selfAttest.forEach((key, value) {
        selfAttestNames.add(key);
        selfAttestValues.add(value);
      });

      opts.schemas.forEach((schemaID, schemaValue) {
        Schema schema;

        if (schemaValue is Schema) {
          schema = schemaValue;
        } else {
          schema = Schema.fromJson(schemaValue);
          handlesToFree.add(schema.handle);
        }

        schemasIDs.add(schemaID);
        schemas.add(schema);
      });

      opts.credentialDefinitions.forEach((key, value) {
        CredentialDefinition credDef;

        if (value is CredentialDefinition) {
          credDef = value;
        } else {
          credDef = CredentialDefinition.fromJson(value);
          handlesToFree.add(credDef.handle);
        }

        credentialDefIDs.add(key);
        credentialDefs.add(credDef);
      });

      return anoncreds
          .createPresentation(
            presentationRequest: opts.presentationRequest,
            credentials: credentials,
            credentialsProve: opts.credentialsProve,
            selfAttestNames: selfAttestNames,
            selfAttestValues: selfAttestValues,
            linkSecret: opts.linkSecret,
            schemas: schemas,
            schemaIds: schemasIDs,
            credentialDefinitions: credentialDefs,
            credentialDefinitionsIds: credentialDefIDs,
          )
          .getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to create presentation: $e");
    } finally {
      for (var handle in handlesToFree) {
        handle.clear();
      }
    }
  }

  factory Presentation.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.presentationFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get presentation from json: $e");
    }
  }

  bool verify(VerifyPresentationOptions options) {
    // TODO
    return false;
  }
}
