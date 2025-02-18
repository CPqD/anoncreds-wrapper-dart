import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

import '../anoncreds_object.dart';

class PresentationRequest extends AnoncredsObject {
  PresentationRequest(super.handle);

  factory PresentationRequest.fromJson(Map<String, dynamic> json) {
    try {
      return anoncreds.presentationRequestFromJson(json).getValueOrException();
    } catch (e) {
      throw AnoncredsException("Failed to get presentation request from json: $e");
    }
  }

  factory PresentationRequest.fromDynamic(dynamic presentationRequest) {
    if (presentationRequest is PresentationRequest) return presentationRequest;

    if (presentationRequest is Map<String, dynamic>) {
      return PresentationRequest.fromJson(presentationRequest);
    }

    throw ArgumentError('Invalid PresentationRequest type');
  }
}
