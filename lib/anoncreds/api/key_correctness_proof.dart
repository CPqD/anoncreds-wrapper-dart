import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

import '../anoncreds_object.dart';

class KeyCorrectnessProof extends AnoncredsObject {
  KeyCorrectnessProof(super.handle);

  factory KeyCorrectnessProof.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.keyCorrectnessProofFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get key correctness proof from json: $e");
    }
  }
}
