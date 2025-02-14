import 'dart:convert';

import '../types.dart';
import '../anoncreds_object.dart';
import '../register.dart';

class PresentationRequest extends AnoncredsObject {
  PresentationRequest(int handle) : super(handle);

  factory PresentationRequest.fromJson(JsonObject json) {
    return PresentationRequest(
      anoncreds?.presentationRequestFromJson(json: jsonEncode(json)).handle ?? 0,
    );
  }
}
