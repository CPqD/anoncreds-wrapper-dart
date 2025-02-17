import 'dart:convert';

import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/object_handle.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

class AnoncredsObject {
  ObjectHandle handle;

  AnoncredsObject(int handle) : handle = ObjectHandle(handle);

  Map<String, dynamic> toJson() {
    try {
      final result = anoncreds.objectGetJson(handle).getValueOrException();

      return jsonDecode(result);
    } catch (e) {
      throw AnoncredsException('Failed to get json from object');
    }
  }

  @override
  String toString() {
    return "${handle.typeName()}(${handle.toInt()})";
  }
}
