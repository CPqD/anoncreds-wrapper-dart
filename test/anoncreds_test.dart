// ignore_for_file: avoid_print

import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/schema.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Anoncreds', () {
    test('Get Version', () async {
      final result = anoncredsVersion();
      print(result);

      expect(result, equals('0.2.0'));
    });

    test('Get Credential Definition', () async {
      final schema = Schema.fromJson({
        'name': 'schema-1',
        'issuerId': 'mock:uri',
        'version': '1',
        'attrNames': ['name', 'age', 'sex', 'height']
      });

      final credDefinitionJson = <String, dynamic>{
        'schemaId': 'mock:uri',
        'issuerId': 'mock:uri',
        'schema': schema,
        'signatureType': 'CL',
        'supportRevocation': true,
        'tag': 'TAG'
      };

      final credDefinition = CredentialDefinition.fromJson(credDefinitionJson);

      final result = credDefinition.toJson();

      expect(result, equals('0.2.0'));
    }, skip: 'Skipping this test until Schema is implemented');
  });
}
