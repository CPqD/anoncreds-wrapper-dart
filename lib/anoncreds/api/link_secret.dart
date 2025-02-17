import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

class LinkSecret {
  static String create() {
    try {
      return anoncreds.createLinkSecret().getValueOrException();
    } catch (e) {
      throw AnoncredsException('Failed to create link secret: $e');
    }
  }
}
