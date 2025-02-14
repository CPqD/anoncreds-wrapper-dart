import 'dart:convert';

import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';
import 'key_correctness_proof.dart';
import '../object_handle.dart';
import 'utils.dart';

class CreateCredentialOfferOptions {
  final String schemaId;
  final String credentialDefinitionId;
  final dynamic keyCorrectnessProof;

  CreateCredentialOfferOptions({
    required this.schemaId,
    required this.credentialDefinitionId,
    required this.keyCorrectnessProof,
  });
}

class CredentialOffer extends AnoncredsObject {
  CredentialOffer(int handle) : super(handle);

  factory CredentialOffer.create(CreateCredentialOfferOptions options) {
    int credentialOfferHandle;
    List<ObjectHandle> objectHandles = [];

    try {
      int keyCorrectnessProof = options.keyCorrectnessProof is KeyCorrectnessProof
          ? options.keyCorrectnessProof.handle
          : pushToArray(KeyCorrectnessProof.fromJson(options.keyCorrectnessProof).handle,
              objectHandles);

      credentialOfferHandle = anoncreds
              ?.createCredentialOffer(
                schemaId: options.schemaId,
                credentialDefinitionId: options.credentialDefinitionId,
                keyCorrectnessProof: ObjectHandle(keyCorrectnessProof),
              )
              .handle ??
          0;
    } finally {
      for (var handle in objectHandles) {
        handle.clear();
      }
    }

    return CredentialOffer(credentialOfferHandle);
  }

  factory CredentialOffer.fromJson(JsonObject json) {
    return CredentialOffer(
      anoncreds?.credentialOfferFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }
}
