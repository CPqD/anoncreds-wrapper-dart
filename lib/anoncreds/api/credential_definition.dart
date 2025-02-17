import 'package:anoncreds_wrapper_dart/anoncreds/api/schema.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/signature_type.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/anoncreds_object.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/object_handle.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/types.dart';

class CredentialDefinition extends AnoncredsObject {
  CredentialDefinition(super.handle);

  static CredentialDefinitionCreation create({
    required String schemaId,
    required dynamic schema,
    required SignatureType signatureType,
    required String tag,
    required String issuerId,
    bool supportRevocation = false,
  }) {
    ObjectHandle schemaHandle;
    List<ObjectHandle> handlesToFree = [];

    if (schema is Schema) {
      schemaHandle = schema.handle;
    } else if (schema is Map<String, dynamic>) {
      schemaHandle = Schema.fromJson(schema).handle;
      handlesToFree.add(schemaHandle);
    } else {
      throw ArgumentError('Invalid schema type');
    }

    try {
      return anoncreds
          .createCredentialDefinition(
              schemaId: schemaId,
              issuerId: issuerId,
              tag: tag,
              schemaHandle: schemaHandle,
              signatureType: signatureType,
              supportRevocation: supportRevocation)
          .getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to create credential definition: $e");
    } finally {
      for (var handle in handlesToFree) {
        handle.clear();
      }
    }
  }

  factory CredentialDefinition.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.credentialDefinitionFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential definition from json: $e");
    }
  }
}
