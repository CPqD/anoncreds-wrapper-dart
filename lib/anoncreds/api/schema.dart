import 'dart:convert';

import '../types.dart';
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
  Schema(int handle) : super(handle);

  factory Schema.create(CreateSchemaOptions options) {
    return Schema(
      anoncreds
              ?.createSchema(
                name: options.name,
                version: options.version,
                issuerId: options.issuerId,
                attributeNames: options.attributeNames,
              )
              .handle ??
          0,
    );
  }

  factory Schema.fromJson(JsonObject json) {
    return Schema(
      anoncreds?.schemaFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }
}
