import 'dart:convert';

import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';

class CredentialDefinitionPrivate extends AnoncredsObject {
  CredentialDefinitionPrivate(int handle) : super(handle);

  factory CredentialDefinitionPrivate.fromJson(JsonObject json) {
    return CredentialDefinitionPrivate(
      anoncreds?.credentialDefinitionPrivateFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }
}
