import 'package:anoncreds_wrapper_dart/anoncreds/anoncreds_object.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

class CredentialRequestMetadata extends AnoncredsObject {
  CredentialRequestMetadata(super.handle);

  factory CredentialRequestMetadata.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsCredentialRequestMetadataFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential request metadata from json: $e");
    }
  }
}
