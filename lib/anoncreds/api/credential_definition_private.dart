import 'package:anoncreds_wrapper_dart/anoncreds/anoncreds_object.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

class CredentialDefinitionPrivate extends AnoncredsObject {
  CredentialDefinitionPrivate(super.handle);

  factory CredentialDefinitionPrivate.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsCredentialDefinitionPrivateFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential definition from json: $e");
    }
  }
}
