// ignore_for_file: avoid_print

import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_definition.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/credential_offer.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/key_correctness_proof.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/presentation_request.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/schema.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/api/utils.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/types.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/error_code.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/enums/signature_type.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Anoncreds', () {
    test('Get Version', () async {
      String result = withPrint(anoncreds.version);

      expect(result, equals('0.2.0'));
    });

    test('Create Schema', () async {
      final createSchemaResult = withPrint(() => Schema.create(
            schemaName: 'schema-1',
            schemaVersion: '1',
            issuerId: 'mock:uri',
            attributeNames: ['attr-1', 'attr-2', 'attr-3'],
          ));

      final schema = withPrint(() => Schema.fromJson(createSchemaResult.toJson()));

      expect(createSchemaResult.toJson(), equals(schema.toJson()));

      createSchemaResult.handle.clear();
      schema.handle.clear();
    });

    test('Create Credential Definition and Offer', () async {
      final schemaJson = <String, dynamic>{
        'name': 'schema-1',
        'issuerId': 'mock:uri',
        'version': '1',
        'attrNames': ['name', 'age', 'sex', 'height']
      };

      final createResult = withPrint(() => CredentialDefinition.create(
            issuerId: 'mock:uri',
            schemaId: 'mock:uri',
            schema: schemaJson,
            signatureType: SignatureType.cl,
            supportRevocation: true,
            tag: 'TAG',
          ));

      final credDefinition = createResult.credentialDefinition;
      final credDefinitionPrivate = createResult.credentialDefinitionPrivate;
      final keyCorrectnessProof = createResult.keyCorrectnessProof;

      final newCredDefinition = withPrint(
        () => CredentialDefinition.fromJson(credDefinition.toJson()),
      );

      expect(credDefinition.toJson(), equals(newCredDefinition.toJson()));

      final credOffer = withPrint(
        () => CredentialOffer.create(
          credentialDefinitionId: 'mock:uri',
          schemaId: 'mock:uri',
          keyCorrectnessProof: keyCorrectnessProof,
        ),
      );

      credDefinition.handle.clear();
      credDefinitionPrivate.handle.clear();
      keyCorrectnessProof.handle.clear();
      newCredDefinition.handle.clear();
      credOffer.handle.clear();
    });

    test('Key Correctness Proof from JSON', () async {
      final keyCorrectnessProof = withPrint(
        () => KeyCorrectnessProof.fromJson({
          "c":
              "78574596389210319574783886762076138478780960760349170184217479308038668584062",
          "xz_cap":
              "1553096204429057037487561890853515674684058925879467043582962818043718936518835296989856499565243162035517965621041818897866688148986589515495944071699647043361910095806925427736259099087993434913717609135994318133800275128122653891609339203435019146046383162998807312020288753122867945453607614529580851304927068824875027592818607091215331472142967121142430395864485741807245301225511616336387114698197617491916939102990288806830007402037124468924602463578126688888420495306593370363706566753874514411532489606472366974046310939463383086356829071253770837656256633056763302664385190916291795218779759050175694484050629707340447114941549376233291583080697548277993700983304873403750465889693271",
          "xr_cap": [
            [
              "name",
              "846163062072682612030674860442150654667237859241033050121474112190579076428074158053528882620984868942044527575806930239786095759971473738739842867306613824964365971886146540822732140133608952554909054354511856894501372820024347342117309558921009843642086985755515940966299490514281124513257465067534459776776073919572312431844858338482602269166483671269604220008616506883665424872769251644092431398527186167455137439678644246752197609859796965805246508653247988322235916679383949665172060812012984762974400132228492872834764767637945612798407301255827320527341688478776169876418734479700973877419569857523683363303221952901823630021008383976500861885632612014700071716968215227880151909593056"
            ],
            [
              "height",
              "66591052082499786076370642446462910690061223053740205825193648778188391648168255169466409796748243904367773479432834057906078792159970394210395572251586414397360043029079568307206187785819266490519768573710255017862758346659619130934016508796991137494602015185083855383677982861114238196061348969816313714208810511481826428763986428333915496129354552576750740270096468539661819354879723573108625761559703418284494316045816505423612058156557139304907668111684921375545082735158005971403132564272924880412664381848287097391315178486442690266435240384899115300930872778986975528546670578571175137136144394607556716062622566790741310615628617925239838242447766920074620889989113056486290841578033"
            ],
            [
              "master_secret",
              "1001435711108076256056126342170802013328015350748009988471174793971636427602970239495971439231079372158185760716113519180209008208471637711442645959152151022021792494217700399830662529632523193182928260636882777305329220099907859019478649541434229422313059883855522290592881256912135805380474721647370700341758734687320498827175105306500013014147239048721434086073578622449391950137777001393508032367259725091524362952368814425843867045859364901047270500590992356426258303234994345052810329609212980276372085929072274881777728824462997273373231847308922137742154687304734757730299642276580284108486655192276007352734208436125209650357881287034895829223767328957587434048126277961621604994328785"
            ],
            [
              "age",
              "679843496679067611136398077639253355313213408366539693050834894456225898507577815463256827438123320273388202416863151085955417218835596382626753385724151510462542757667840978691912548023742400253031704481287433154770468847082034739548067776410705361371817216906613672856201601737759965610320157683214963100523642064222522666741846734381450523145264664149937062024661631902356268563870186335980274898387573714579031599967398396662576598074017515019265322319620519052713634561225242536853528945163809959159189988529049259427588982287910962719934933019878725672831456852963042441560728921135434145880406488916209095846934620931251182488267178690150976926373965545066731850520094570111830106176400"
            ]
          ]
        }),
      );

      keyCorrectnessProof.handle.clear();
    });

    test('Presentation Request from JSON', () async {
      final nonce = AnoncredsUtils.generateNonce();
      print('nonce: $nonce');

      final json = <String, dynamic>{
        'name': 'pres_req_1',
        'nonce': nonce,
        'version': '0.1',
        'requested_attributes': {
          'attr1_referent': {'name': 'name', 'issuer': 'mock:uri'},
          'attr2_referent': {'name': 'phone'},
        },
        'requested_predicates': {
          'predicate1_referent': {'name': 'age', 'p_type': '>=', 'p_value': 18}
        },
      };

      final presentationRequest = withPrint(() => PresentationRequest.fromJson(json));

      presentationRequest.handle.clear();
    });

    test('Create Link Secret', () async {
      createLinkSecretTest();
    });
  });
}

AnoncredsResult<String> createLinkSecretTest() {
  final result = anoncreds.createLinkSecret();

  printAnoncredsResult('Create Link Secret', result);

  expect(result.errorCode, equals(ErrorCode.success));
  expect(result.value, isNotNull);
  expect(result.value, isA<String>());

  return result;
}

void printAnoncredsResult(String test, dynamic result) {
  print('$test: $result\n');
}

T withPrint<T>(T Function() fn) {
  final result = fn();
  print(result);
  return result;
}
