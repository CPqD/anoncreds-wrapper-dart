import 'dart:convert';

import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';

class RevocationRegistryDefinitionPrivate extends AnoncredsObject {
  RevocationRegistryDefinitionPrivate(int handle) : super(handle);

  factory RevocationRegistryDefinitionPrivate.fromJson(JsonObject json) {
    return RevocationRegistryDefinitionPrivate(
      anoncreds
              ?.revocationRegistryDefinitionPrivateFromJson(json: jsonEncode(json))
              .handle ??
          0,
    );
  }
}
