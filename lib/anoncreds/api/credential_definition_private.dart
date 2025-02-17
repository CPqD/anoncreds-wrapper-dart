import 'package:anoncreds_wrapper_dart/anoncreds/anoncreds_object.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

class CredentialDefinitionPrivate extends AnoncredsObject {
  CredentialDefinitionPrivate(super.handle);

  factory CredentialDefinitionPrivate.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.credentialDefinitionPrivateFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential definition from json: $e");
    }
  }
}
