import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds_object.dart';
import '../object_handle.dart';
import '../register.dart';
import 'credential_definition.dart';
import 'credential_offer.dart';
import 'utils.dart';

class CreateCredentialRequestOptions {
  final String? entropy;
  final String? proverDid;
  final dynamic credentialDefinition;
  final String linkSecret;
  final String linkSecretId;
  final dynamic credentialOffer;

  CreateCredentialRequestOptions({
    this.entropy,
    this.proverDid,
    required this.credentialDefinition,
    required this.linkSecret,
    required this.linkSecretId,
    required this.credentialOffer,
  });
}

class CredentialRequest extends AnoncredsObject {
  CredentialRequest(super.handle);

  factory CredentialRequest.create(CreateCredentialRequestOptions options) {
    late Map<String, ObjectHandle> createReturnObj;
    List<ObjectHandle> objectHandles = [];

    try {
      int credentialDefinition = options.credentialDefinition is CredentialDefinition
          ? options.credentialDefinition.handle
          : pushToArray(
              CredentialDefinition.fromJson(options.credentialDefinition).handle,
              objectHandles);

      int credentialOffer = options.credentialOffer is CredentialOffer
          ? options.credentialOffer.handle
          : pushToArray(
              CredentialOffer.fromJson(options.credentialOffer).handle, objectHandles);

      createReturnObj = anoncreds.createCredentialRequest(
        entropy: options.entropy,
        proverDid: options.proverDid,
        credentialDefinition: ObjectHandle(credentialDefinition),
        linkSecret: options.linkSecret,
        linkSecretId: options.linkSecretId,
        credentialOffer: ObjectHandle(credentialOffer),
      );
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return CredentialRequest(createReturnObj['credentialRequest']!.handle);
  }

  factory CredentialRequest.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.credentialRequestFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get credential offer from json: $e");
    }
  }
}
