import 'dart:ffi';

import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_native_functions.dart';
import 'package:ffi/ffi.dart';

String anoncredsVersion() {
  Pointer<Utf8> resultPointer = nullptr;

  try {
    resultPointer = nativeAnoncredsVersion();
    return resultPointer.toDartString();
  } finally {
    freePointer(resultPointer);
  }
}

void freePointer(Pointer<NativeType> pointer) {
  if (pointer != nullptr) {
    calloc.free(pointer);
  }
}
