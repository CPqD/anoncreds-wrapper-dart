import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

class AnoncredsUtils {
  static String generateNonce() {
    try {
      return anoncreds.generateNonce().getValueOrException();
    } catch (e) {
      throw AnoncredsException('Failed to generate nonce: $e');
    }
  }
}

List<T> pushToArray<T>(T obj, List<T> arr) {
  arr.add(obj);
  return arr;
}
