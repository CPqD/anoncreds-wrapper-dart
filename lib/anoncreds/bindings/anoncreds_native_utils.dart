import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_native_types.dart';
import 'package:ffi/ffi.dart';

Pointer<FfiByteBuffer> stringToByteBuffer(String value) {
  return bytesListToByteBuffer(utf8.encode(value));
}

Pointer<FfiByteBuffer> bytesListToByteBuffer(Uint8List? bytesList) {
  if (bytesList == null) {
    return calloc<FfiByteBuffer>();
  }

  Pointer<Uint8> dataPointer = calloc<Uint8>(bytesList.length);

  for (int i = 0; i < bytesList.length; i++) {
    dataPointer[i] = bytesList[i];
  }

  Pointer<FfiByteBuffer> byteBufferPointer = calloc<FfiByteBuffer>();

  byteBufferPointer.ref.len = bytesList.length;
  byteBufferPointer.ref.data = dataPointer;

  return byteBufferPointer;
}

String byteBufferToString(FfiByteBuffer secretBuffer) {
  return utf8.decode(byteBufferToBytesList(secretBuffer));
}

Uint8List byteBufferToBytesList(FfiByteBuffer secretBuffer) {
  int length = secretBuffer.len;
  Pointer<Uint8> dataPointer = secretBuffer.data;

  return Uint8List.fromList(dataPointer.asTypedList(length));
}

int boolToInt(bool value) {
  return value ? 1 : 0;
}

Uint8List generateRandomSeed() {
  final random = Random.secure();
  final seed = List<int>.generate(32, (_) => random.nextInt(256));
  return Uint8List.fromList(seed);
}

bool intToBool(int value) {
  switch (value) {
    case 0:
      return false;
    case 1:
      return true;
    default:
      throw ArgumentError('Invalid bool value: $value');
  }
}

void freeByteBufferPointer(Pointer<FfiByteBuffer> byteBufferPtr) {
  if (byteBufferPtr == nullptr) return;

  freePointer(byteBufferPtr.ref.data);

  calloc.free(byteBufferPtr);
}

void freeDoublePointer(Pointer<Pointer<NativeType>> doublePointer) {
  if (doublePointer == nullptr) return;

  freePointer(doublePointer.value);

  calloc.free(doublePointer);
}

void freePointer(Pointer<NativeType> pointer) {
  if (pointer != nullptr) {
    calloc.free(pointer);
  }
}
