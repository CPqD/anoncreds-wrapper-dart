import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds_object.dart';
import '../register.dart';

class CreateSchemaOptions {
  final String name;
  final String version;
  final String issuerId;
  final List<String> attributeNames;

  CreateSchemaOptions({
    required this.name,
    required this.version,
    required this.issuerId,
    required this.attributeNames,
  });
}

class Schema extends AnoncredsObject {
  Schema(super.handle);

  static Schema create({
    required String schemaName,
    required String schemaVersion,
    required String issuerId,
    required List<String> attributeNames,
  }) {
    try {
      return anoncreds
          .createSchema(
              name: schemaName,
              version: schemaVersion,
              issuerId: issuerId,
              attributeNames: attributeNames)
          .getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to create schema: $e");
    }
  }

  factory Schema.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.schemaFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get schema from json: $e");
    }
  }
}
