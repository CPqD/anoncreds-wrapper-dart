import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

class LinkSecret {
  static String create() {
    try{
      return anoncredsCreateLinkSecret().getValueOrException();
    } catch(e){
      throw AnoncredsException('Failed to create link secret: $e');
    }
  }
}
