import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
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

  factory Schema.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsSchemaFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get schema from json: $e");
    }
  }
}
