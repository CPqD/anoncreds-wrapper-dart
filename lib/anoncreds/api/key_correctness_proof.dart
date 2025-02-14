import 'dart:convert';

import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';

class KeyCorrectnessProof extends AnoncredsObject {
  KeyCorrectnessProof(int handle) : super(handle);

  factory KeyCorrectnessProof.fromJson(JsonObject json) {
    return KeyCorrectnessProof(
      anoncreds?.keyCorrectnessProofFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }
}
