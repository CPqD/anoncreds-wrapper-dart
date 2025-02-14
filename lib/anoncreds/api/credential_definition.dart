import 'dart:convert';

import '../anoncreds_object.dart';
import '../object_handle.dart';
import '../types.dart';
import '../register.dart';
import 'credential_definition_private.dart';
import 'key_correctness_proof.dart';
import 'schema.dart';
import 'utils.dart';

class CreateCredentialDefinitionOptions {
  final String schemaId;
  final dynamic schema;
  final String signatureType;
  final String tag;
  final String issuerId;
  final bool? supportRevocation;

  CreateCredentialDefinitionOptions({
    required this.schemaId,
    required this.schema,
    required this.signatureType,
    required this.tag,
    required this.issuerId,
    this.supportRevocation,
  });
}

class CredentialDefinition extends AnoncredsObject {
  CredentialDefinition(int handle) : super(handle);

  static Map<String, dynamic> create(CreateCredentialDefinitionOptions options) {
    late Map<String, ObjectHandle> createReturnObj;
    List<ObjectHandle> objectHandles = [];

    try {
      int schema = options.schema is Schema
          ? options.schema.handle
          : pushToArray(Schema.fromJson(options.schema).handle, objectHandles);
      createReturnObj = anoncreds!.createCredentialDefinition(
        schemaId: options.schemaId,
        schema: ObjectHandle(schema),
        signatureType: options.signatureType,
        tag: options.tag,
        issuerId: options.issuerId,
        supportRevocation: options.supportRevocation ?? false,
      );
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return {
      'credentialDefinition':
          CredentialDefinition(createReturnObj['credentialDefinition']!.handle),
      'credentialDefinitionPrivate': CredentialDefinitionPrivate(
          createReturnObj['credentialDefinitionPrivate']!.handle),
      'keyCorrectnessProof':
          KeyCorrectnessProof(createReturnObj['keyCorrectnessProof']!.handle),
    };
  }

  static CredentialDefinition fromJson(JsonObject json) {
    return CredentialDefinition(
      anoncreds!.credentialDefinitionFromJson(json: jsonEncode(json)).handle,
    );
  }
}
