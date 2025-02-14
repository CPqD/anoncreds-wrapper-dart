// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';
import 'dart:io';

import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_native_types.dart';
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

final void Function(Pointer<FfiByteBuffer>) nativeAnoncredsBufferFree = nativeLib
    .lookup<NativeFunction<Void Function(Pointer<FfiByteBuffer>)>>(
        'anoncreds_buffer_free')
    .asFunction();

final int Function(
  int cred_def,
  int cred_def_private,
  int cred_offer,
  int cred_request,
  Pointer<FfiStrList> attr_names,
  Pointer<FfiStrList> attr_raw_values,
  Pointer<FfiStrList> attr_enc_values,
  Pointer<FfiCredRevInfo> revocation,
  Pointer<Int64> cred_p,
) nativeAnoncredsCreateCredential = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Int64,
                Int64,
                Int64,
                Pointer<FfiStrList>,
                Pointer<FfiStrList>,
                Pointer<FfiStrList>,
                Pointer<FfiCredRevInfo>,
                Pointer<Int64>)>>('anoncreds_create_credential')
    .asFunction();

final int Function(
  Pointer<Utf8> schema_id,
  int schema,
  Pointer<Utf8> tag,
  Pointer<Utf8> issuer_id,
  Pointer<Utf8> signature_type,
  int support_revocation,
  Pointer<Int64> cred_def_p,
  Pointer<Int64> cred_def_pvt_p,
  Pointer<Int64> key_proof_p,
) nativeAnoncredsCreateCredentialDefinition = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Pointer<Utf8>,
                Int64,
                Pointer<Utf8>,
                Pointer<Utf8>,
                Pointer<Utf8>,
                Int8,
                Pointer<Int64>,
                Pointer<Int64>,
                Pointer<Int64>)>>('anoncreds_create_credential_definition')
    .asFunction();

final int Function(
  Pointer<Utf8> schema_id,
  Pointer<Utf8> cred_def_id,
  int key_proof,
  Pointer<Int64> cred_offer_p,
) nativeAnoncredsCreateCredentialOffer = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Int64,
                Pointer<Int64>)>>('anoncreds_create_credential_offer')
    .asFunction();

final int Function(
  Pointer<Utf8> entropy,
  Pointer<Utf8> prover_did,
  int cred_def,
  Pointer<Utf8> link_secret,
  Pointer<Utf8> link_secret_id,
  int cred_offer,
  Pointer<Int64> cred_req_p,
  Pointer<Int64> cred_req_meta_p,
) nativeAnoncredsCreateCredentialRequest = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Pointer<Utf8>,
                Pointer<Utf8>,
                Int64,
                Pointer<Utf8>,
                Pointer<Utf8>,
                Int64,
                Pointer<Int64>,
                Pointer<Int64>)>>('anoncreds_create_credential_request')
    .asFunction();

final int Function(
  Pointer<Pointer<Utf8>> link_secret_p,
) nativeAnoncredsCreateLinkSecret = nativeLib
    .lookup<NativeFunction<Int32 Function(Pointer<Pointer<Utf8>>)>>(
        'anoncreds_create_link_secret')
    .asFunction();

final int Function(
  int rev_reg_def,
  int rev_status_list,
  int rev_reg_index,
  Pointer<Utf8> tails_path,
  int rev_state,
  int old_rev_status_list,
  Pointer<Int64> rev_state_p,
) nativeAnoncredsCreateOrUpdateRevocationState = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(Int64, Int64, Int64, Pointer<Utf8>, Int64, Int64,
                Pointer<Int64>)>>('anoncreds_create_or_update_revocation_state')
    .asFunction();

final int Function(
  int pres_req,
  Pointer<FfiListFfiCredentialEntry> credentials,
  Pointer<FfiListFfiCredentialProve> credentials_prove,
  Pointer<FfiStrList> self_attest_names,
  Pointer<FfiStrList> self_attest_values,
  Pointer<Utf8> link_secret,
  Pointer<FfiListObjectHandle> schemas,
  Pointer<FfiStrList> schema_ids,
  Pointer<FfiListObjectHandle> cred_defs,
  Pointer<FfiStrList> cred_def_ids,
  Pointer<Int64> presentation_p,
) nativeAnoncredsCreatePresentation = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Pointer<FfiListFfiCredentialEntry>,
                Pointer<FfiListFfiCredentialProve>,
                Pointer<FfiStrList>,
                Pointer<FfiStrList>,
                Pointer<Utf8>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<Int64>)>>('anoncreds_create_presentation')
    .asFunction();

final int Function(
  int cred_def,
  Pointer<Utf8> cred_def_id,
  Pointer<Utf8> issuer_id,
  Pointer<Utf8> tag,
  Pointer<Utf8> rev_reg_type,
  int max_cred_num,
  Pointer<Utf8> tails_dir_path,
  Pointer<Int64> reg_def_p,
  Pointer<Int64> reg_def_private_p,
) nativeAnoncredsCreateRevocationRegistryDef = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Pointer<Utf8>,
                Pointer<Utf8>,
                Pointer<Utf8>,
                Pointer<Utf8>,
                Int64,
                Pointer<Utf8>,
                Pointer<Int64>,
                Pointer<Int64>)>>('anoncreds_create_revocation_registry_def')
    .asFunction();

final int Function(
  int cred_def,
  Pointer<Utf8> rev_reg_def_id,
  int rev_reg_def,
  int reg_rev_priv,
  Pointer<Utf8> issuer_id,
  int issuance_by_default,
  int timestamp,
  Pointer<Int64> rev_status_list_p,
) nativeAnoncredsCreateRevocationStatusList = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(Int64, Pointer<Utf8>, Int64, Int64, Pointer<Utf8>, Int8, Int64,
                Pointer<Int64>)>>('anoncreds_create_revocation_status_list')
    .asFunction();

final int Function(
  Pointer<Utf8> schema_name,
  Pointer<Utf8> schema_version,
  Pointer<Utf8> issuer_id,
  Pointer<FfiStrList> attr_names,
  Pointer<Int64> result_p,
) nativeAnoncredsCreateSchema = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>,
                Pointer<FfiStrList>, Pointer<Int64>)>>('anoncreds_create_schema')
    .asFunction();

final int Function(
  int cred_def,
  int cred_def_private,
  int cred_offer,
  int cred_request,
  Pointer<FfiStrList> attr_names,
  Pointer<FfiStrList> attr_raw_values,
  Pointer<FfiCredRevInfo> revocation,
  Pointer<Utf8> w3c_version,
  Pointer<Int64> cred_p,
) nativeAnoncredsCreateW3cCredential = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Int64,
                Int64,
                Int64,
                Pointer<FfiStrList>,
                Pointer<FfiStrList>,
                Pointer<FfiCredRevInfo>,
                Pointer<Utf8>,
                Pointer<Int64>)>>('anoncreds_create_w3c_credential')
    .asFunction();

final int Function(
  int pres_req,
  Pointer<FfiListFfiCredentialEntry> credentials,
  Pointer<FfiListFfiCredentialProve> credentials_prove,
  Pointer<Utf8> link_secret,
  Pointer<FfiListObjectHandle> schemas,
  Pointer<FfiStrList> schema_ids,
  Pointer<FfiListObjectHandle> cred_defs,
  Pointer<FfiStrList> cred_def_ids,
  Pointer<Utf8> w3c_version,
  Pointer<Int64> presentation_p,
) nativeAnoncredsCreateW3cPresentation = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Pointer<FfiListFfiCredentialEntry>,
                Pointer<FfiListFfiCredentialProve>,
                Pointer<Utf8>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<Utf8>,
                Pointer<Int64>)>>('anoncreds_create_w3c_presentation')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsCredentialDefinitionFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_credential_definition_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsCredentialDefinitionPrivateFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_credential_definition_private_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsCredentialFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_credential_from_json')
    .asFunction();

final int Function(
  int cred,
  Pointer<Int64> cred_p,
) nativeAnoncredsCredentialFromW3c = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Pointer<Int64>)>>(
        'anoncreds_credential_from_w3c')
    .asFunction();

final int Function(
  int handle,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> result_p,
) nativeAnoncredsCredentialGetAttribute = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Pointer<Utf8>, Pointer<Pointer<Utf8>>)>>(
        'anoncreds_credential_get_attribute')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsCredentialOfferFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_credential_offer_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsCredentialRequestFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_credential_request_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsCredentialRequestMetadataFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_credential_request_metadata_from_json')
    .asFunction();

final int Function(
  int cred,
  Pointer<Utf8> issuer_id,
  Pointer<Utf8> w3c_version,
  Pointer<Int64> cred_p,
) nativeAnoncredsCredentialToW3c = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(Int64, Pointer<Utf8>, Pointer<Utf8>,
                Pointer<Int64>)>>('anoncreds_credential_to_w3c')
    .asFunction();

final int Function(
  Pointer<FfiStrList> attr_raw_values,
  Pointer<Pointer<Utf8>> result_p,
) nativeAnoncredsEncodeCredentialAttributes = nativeLib
    .lookup<NativeFunction<Int32 Function(Pointer<FfiStrList>, Pointer<Pointer<Utf8>>)>>(
        'anoncreds_encode_credential_attributes')
    .asFunction();

final int Function(
  Pointer<Pointer<Utf8>> nonce_p,
) nativeAnoncredsGenerateNonce = nativeLib
    .lookup<NativeFunction<Int32 Function(Pointer<Pointer<Utf8>>)>>(
        'anoncreds_generate_nonce')
    .asFunction();

final int Function(
  Pointer<Pointer<Utf8>> error_json_p,
) nativeAnoncredsGetCurrentError = nativeLib
    .lookup<NativeFunction<Int32 Function(Pointer<Pointer<Utf8>>)>>(
        'anoncreds_get_current_error')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsKeyCorrectnessProofFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_key_correctness_proof_from_json')
    .asFunction();

final void Function(
  int handle,
) nativeAnoncredsObjectFree = nativeLib
    .lookup<NativeFunction<Void Function(Int64)>>('anoncreds_object_free')
    .asFunction();

final int Function(
  int handle,
  Pointer<FfiByteBuffer> result_p,
) nativeAnoncredsObjectGetJson = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Pointer<FfiByteBuffer>)>>(
        'anoncreds_object_get_json')
    .asFunction();

final int Function(
  int handle,
  Pointer<Pointer<Utf8>> result_p,
) nativeAnoncredsObjectGetTypeName = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Pointer<Pointer<Utf8>>)>>(
        'anoncreds_object_get_type_name')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsPresentationFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_presentation_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsPresentationRequestFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_presentation_request_from_json')
    .asFunction();

final int Function(
  int cred,
  int cred_req_metadata,
  Pointer<Utf8> link_secret,
  int cred_def,
  int rev_reg_def,
  Pointer<Int64> cred_p,
) nativeAnoncredsProcessCredential = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(Int64, Int64, Pointer<Utf8>, Int64, Int64,
                Pointer<Int64>)>>('anoncreds_process_credential')
    .asFunction();

final int Function(
  int cred,
  int cred_req_metadata,
  Pointer<Utf8> link_secret,
  int cred_def,
  int rev_reg_def,
  Pointer<Int64> cred_p,
) nativeAnoncredsProcessW3cCredential = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(Int64, Int64, Pointer<Utf8>, Int64, Int64,
                Pointer<Int64>)>>('anoncreds_process_w3c_credential')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsRevocationRegistryDefinitionFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_revocation_registry_definition_from_json')
    .asFunction();

final int Function(
  int handle,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> result_p,
) nativeAnoncredsRevocationRegistryDefinitionGetAttribute = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Pointer<Utf8>, Pointer<Pointer<Utf8>>)>>(
        'anoncreds_revocation_registry_definition_get_attribute')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsRevocationRegistryDefinitionPrivateFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_revocation_registry_definition_private_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsRevocationRegistryFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_revocation_registry_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsRevocationStateFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_revocation_state_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsRevocationStatusListFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_revocation_status_list_from_json')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsSchemaFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_schema_from_json')
    .asFunction();

final int Function() nativeAnoncredsSetDefaultLogger = nativeLib
    .lookup<NativeFunction<Int32 Function()>>('anoncreds_set_default_logger')
    .asFunction();

final void Function(
  Pointer<Utf8> s,
) nativeAnoncredsStringFree = nativeLib
    .lookup<NativeFunction<Void Function(Pointer<Utf8>)>>('anoncreds_string_free')
    .asFunction();

final int Function(
  int cred_def,
  int rev_reg_def,
  int rev_reg_priv,
  int rev_current_list,
  Pointer<FfiListi32> issued,
  Pointer<FfiListi32> revoked,
  int timestamp,
  Pointer<Int64> new_rev_status_list_p,
) nativeAnoncredsUpdateRevocationStatusList = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Int64,
                Int64,
                Int64,
                Pointer<FfiListi32>,
                Pointer<FfiListi32>,
                Int64,
                Pointer<Int64>)>>('anoncreds_update_revocation_status_list')
    .asFunction();

final int Function(
  int timestamp,
  int rev_current_list,
  Pointer<Int64> rev_status_list_p,
) nativeAnoncredsUpdateRevocationStatusListTimestampOnly = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Int64, Pointer<Int64>)>>(
        'anoncreds_update_revocation_status_list_timestamp_only')
    .asFunction();

final int Function(
  int presentation,
  int pres_req,
  Pointer<FfiListObjectHandle> schemas,
  Pointer<FfiStrList> schema_ids,
  Pointer<FfiListObjectHandle> cred_defs,
  Pointer<FfiStrList> cred_def_ids,
  Pointer<FfiListObjectHandle> rev_reg_defs,
  Pointer<FfiStrList> rev_reg_def_ids,
  Pointer<FfiListObjectHandle> rev_status_list,
  Pointer<FfiListFfiNonrevokedIntervalOverride> nonrevoked_interval_override,
  Pointer<Int8> result_p,
) nativeAnoncredsVerifyPresentation = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Int64,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiListFfiNonrevokedIntervalOverride>,
                Pointer<Int8>)>>('anoncreds_verify_presentation')
    .asFunction();

final int Function(
  int presentation,
  int pres_req,
  Pointer<FfiListObjectHandle> schemas,
  Pointer<FfiStrList> schema_ids,
  Pointer<FfiListObjectHandle> cred_defs,
  Pointer<FfiStrList> cred_def_ids,
  Pointer<FfiListObjectHandle> rev_reg_defs,
  Pointer<FfiStrList> rev_reg_def_ids,
  Pointer<FfiListObjectHandle> rev_status_list,
  Pointer<FfiListFfiNonrevokedIntervalOverride> nonrevoked_interval_override,
  Pointer<Int8> result_p,
) nativeAnoncredsVerifyW3cPresentation = nativeLib
    .lookup<
        NativeFunction<
            Int32 Function(
                Int64,
                Int64,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiStrList>,
                Pointer<FfiListObjectHandle>,
                Pointer<FfiListFfiNonrevokedIntervalOverride>,
                Pointer<Int8>)>>('anoncreds_verify_w3c_presentation')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsW3cCredentialFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_w3c_credential_from_json')
    .asFunction();

final int Function(
  int handle,
  Pointer<Int64> cred_proof_info_p,
) nativeAnoncredsW3cCredentialGetIntegrityProofDetails = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Pointer<Int64>)>>(
        'anoncreds_w3c_credential_get_integrity_proof_details')
    .asFunction();

final int Function(
  int handle,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> result_p,
) nativeAnoncredsW3cCredentialProofGetAttribute = nativeLib
    .lookup<NativeFunction<Int32 Function(Int64, Pointer<Utf8>, Pointer<Pointer<Utf8>>)>>(
        'anoncreds_w3c_credential_proof_get_attribute')
    .asFunction();

final int Function(
  FfiByteBuffer json,
  Pointer<Int64> result_p,
) nativeAnoncredsW3cPresentationFromJson = nativeLib
    .lookup<NativeFunction<Int32 Function(FfiByteBuffer, Pointer<Int64>)>>(
        'anoncreds_w3c_presentation_from_json')
    .asFunction();
