// ignore_for_file: avoid_print

import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/types.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/error_code.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/signature_type.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Anoncreds', () {
    test('Get Version', () async {
      final result = anoncreds.version();
      print(result);

      expect(result, equals('0.2.0'));
    });

    test('Get Credential Definition', () async {
      final schemaJson = <String, dynamic>{
        'name': 'schema-1',
        'issuerId': 'mock:uri',
        'version': '1',
        'attrNames': ['name', 'age', 'sex', 'height']
      };

      final createResult = CredentialDefinition.create(
        issuerId: 'mock:uri',
        schemaId: 'mock:uri',
        schema: schemaJson,
        signatureType: SignatureType.cl,
        supportRevocation: true,
        tag: 'TAG',
      );

      final credDefinition = createResult.credentialDefinition;
      print(credDefinition);

      final credDefinitionPrivate = createResult.credentialDefinitionPrivate;
      print(credDefinitionPrivate);

      final keyCorrectnessProof = createResult.keyCorrectnessProof;
      print(keyCorrectnessProof);

      credDefinition.handle.clear();
      credDefinitionPrivate.handle.clear();
      keyCorrectnessProof.handle.clear();
    });
    test('Create Link Secret', () async {
      createLinkSecretTest();
    });
  });
}

AnoncredsResult<String> createLinkSecretTest() {
  final result = anoncreds.createLinkSecret();

  printAnoncredsResult('Create Link Secret', result);

  expect(result.errorCode, equals(ErrorCode.success));
  expect(result.value, isNotNull);
  expect(result.value, isA<String>());

  return result;
}

void printAnoncredsResult(String test, dynamic result) {
  print('$test: $result\n');
}
