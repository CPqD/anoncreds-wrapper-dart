import 'dart:ffi';

import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_native_types.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';
import 'package:ffi/ffi.dart';

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

Pointer<FfiStrList> toFfiStrList(List<String> attributeNames) {
  Pointer<FfiStrList> ffiStrList = calloc<FfiStrList>();
  Pointer<Pointer<Utf8>> utf8PtrArray = calloc<Pointer<Utf8>>(attributeNames.length);

  for (int i = 0; i < attributeNames.length; i++) {
    utf8PtrArray[i] = attributeNames[i].toNativeUtf8();
  }

  ffiStrList.ref.count = attributeNames.length;
  ffiStrList.ref.data = utf8PtrArray;

  return ffiStrList;
}
