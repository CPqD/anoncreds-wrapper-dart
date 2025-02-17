import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/anoncreds_object.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

import 'key_correctness_proof.dart';

class CredentialOffer extends AnoncredsObject {
  CredentialOffer(super.handle);

  static CredentialOffer create({
    required String schemaId,
    required String credentialDefinitionId,
    required KeyCorrectnessProof keyCorrectnessProof,
  }) {
    throw NotImplementedException("CredentialOffer.create");
  }

  factory CredentialOffer.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.credentialOfferFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential offer from json: $e");
    }
  }
}
