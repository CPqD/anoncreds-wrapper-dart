import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/object_handle.dart';

class Schema extends ObjectHandle {
  Schema(super.handle);

  static create({
    required String name,
    required String version,
    required String issuerId,
    required List<String> attributeNames,
  }) {
    throw NotImplementedException("Schema.create");
  }

  // TODO
  static Schema fromJson(Map<String, dynamic> json) {
    throw NotImplementedException("Schema.fromJson");
  }
}
