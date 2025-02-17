import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

import '../anoncreds_object.dart';

class RevocationRegistryDefinitionPrivate extends AnoncredsObject {
  RevocationRegistryDefinitionPrivate(super.handle);

  factory RevocationRegistryDefinitionPrivate.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds
          .revocationRegistryDefinitionPrivateFromJson(json)
          .getValueOrException();
    } catch (e) {
      throw AnoncredsException(
          "Failed to get revocation registry definition private from json: $e");
    }
  }
}
