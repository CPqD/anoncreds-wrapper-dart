import 'dart:convert';

import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';

class CredentialRequestMetadata extends AnoncredsObject {
  CredentialRequestMetadata(int handle) : super(handle);

  factory CredentialRequestMetadata.fromJson(JsonObject json) {
    return CredentialRequestMetadata(
      anoncreds?.credentialRequestMetadataFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }
}
