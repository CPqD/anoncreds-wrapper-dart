import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

import '../anoncreds_object.dart';

class PresentationRequest extends AnoncredsObject {
  PresentationRequest(super.handle);

  factory PresentationRequest.fromJson(Map<String, dynamic> json) {
    try {
      return anoncredsPresentationRequestFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get presentation request from json: $e");
    }
  }
}
