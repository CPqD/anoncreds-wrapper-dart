// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:ffi/ffi.dart';

base class FfiByteBuffer extends Struct {
  @Int64()
  external int len;

  external Pointer<Uint8> data;
}

base class FfiStrList extends Struct {
  @Int64()
  external int count;
  external Pointer<Pointer<Utf8>> data;
}

base class FfiCredRevInfo extends Struct {
  @Int64()
  external int reg_def;
  @Int64()
  external int reg_def_private;
  @Int64()
  external int status_list;
  @Int64()
  external int reg_idx;
}

base class FfiCredentialEntry extends Struct {
  @Int64()
  external int credential;
  @Int32()
  external int timestamp;
  @Int64()
  external int rev_state;
}

base class FfiCredentialProve extends Struct {
  @Int64()
  external int entry_idx;
  external Pointer<Utf8> referent;
  @Int8()
  external int is_predicate;
  @Int8()
  external int reveal;
}

base class FfiNonrevokedIntervalOverride extends Struct {
  external Pointer<Utf8> rev_reg_def_id;
  @Int32()
  external int requested_from_ts;
  @Int32()
  external int override_rev_status_list_ts;
}

base class FfiListFfiCredentialEntry extends Struct {
  @Int64()
  external int count;
  external Pointer<FfiCredentialEntry> data;
}

base class FfiListFfiCredentialProve extends Struct {
  @Int64()
  external int count;
  external Pointer<FfiCredentialProve> data;
}

base class FfiListObjectHandle extends Struct {
  @Int64()
  external int count;
  external Pointer<Int64> data;
}

base class FfiListi32 extends Struct {
  @Int64()
  external int count;
  external Pointer<Int32> data;
}

base class FfiListFfiNonrevokedIntervalOverride extends Struct {
  @Int64()
  external int count;
  external Pointer<FfiNonrevokedIntervalOverride> data;
}
