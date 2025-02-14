import 'dart:convert';
import 'types.dart';
import 'object_handle.dart';
import 'register.dart';

class AnoncredsObject {
  ObjectHandle handle;

  AnoncredsObject(int handle) : handle = ObjectHandle(handle);

  JsonObject toJson() {
    final jsonString = anoncreds?.getJson(objectHandle: handle) ?? '{}';
    return jsonDecode(jsonString) as JsonObject;
  }
}
