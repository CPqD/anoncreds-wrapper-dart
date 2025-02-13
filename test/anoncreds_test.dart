import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Anoncreds Tests', () {
    test('Get Version', () async {
      final result = anoncredsVersion();
      print(result);

      expect(result, equals('0.2.0'));
    });
  });
}
