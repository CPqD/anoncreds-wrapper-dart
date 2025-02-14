import 'dart:convert';

import 'revocation_registry_definition.dart';
import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';

class UpdateRevocationRegistryOptions {
  final RevocationRegistryDefinition revocationRegistryDefinition;
  final List<int> issued;
  final List<int> revoked;
  final String tailsDirectoryPath;

  UpdateRevocationRegistryOptions({
    required this.revocationRegistryDefinition,
    required this.issued,
    required this.revoked,
    required this.tailsDirectoryPath,
  });
}

class RevocationRegistry extends AnoncredsObject {
  RevocationRegistry(int handle) : super(handle);

  factory RevocationRegistry.fromJson(JsonObject json) {
    return RevocationRegistry(
      anoncreds?.revocationRegistryFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }
}
