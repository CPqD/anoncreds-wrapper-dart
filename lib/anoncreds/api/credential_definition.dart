import 'package:anoncreds_wrapper_dart/anoncreds/api/schema.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/anoncreds_object.dart';

class CredentialDefinition extends AnoncredsObject {
  CredentialDefinition(super.handle);

  static Map<String, dynamic> create({
    required String schemaId,
    required Schema schema,
    required String signatureType,
    required String tag,
    required String issuerId,
    bool supportRevocation = false,
  }) {
    throw NotImplementedException("CredentialDefinition.create");
  }

  factory CredentialDefinition.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsCredentialDefinitionFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential definition from json: $e");
    }
  }
}
