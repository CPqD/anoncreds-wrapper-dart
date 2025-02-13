// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

final DynamicLibrary nativeLib = Platform.isIOS
    ? DynamicLibrary.process()
    : DynamicLibrary.open(getLibAnoncredsPath());

String getLibAnoncredsPath() {
  return Platform.isAndroid ? 'libanoncreds.so' : 'linux/lib/libanoncreds.so';
}

final Pointer<Utf8> Function() nativeAnoncredsVersion = nativeLib
    .lookup<NativeFunction<Pointer<Utf8> Function()>>('anoncreds_version')
    .asFunction();
