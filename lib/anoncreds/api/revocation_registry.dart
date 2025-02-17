import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

import '../anoncreds_object.dart';

class RevocationRegistry extends AnoncredsObject {
  RevocationRegistry(super.handle);

  factory RevocationRegistry.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.revocationRegistryFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get revocation registry offer from json: $e");
    }
  }
}
