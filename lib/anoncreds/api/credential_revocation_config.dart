import '../anoncreds.dart';
import 'revocation_registry_definition.dart';
import 'revocation_registry_definition_private.dart';
import 'revocation_status_list.dart';

class CredentialRevocationConfigOptions {
  final RevocationRegistryDefinition registryDefinition;
  final RevocationRegistryDefinitionPrivate registryDefinitionPrivate;
  final RevocationStatusList statusList;
  final int registryIndex;

  CredentialRevocationConfigOptions({
    required this.registryDefinition,
    required this.registryDefinitionPrivate,
    required this.statusList,
    required this.registryIndex,
  });
}

class CredentialRevocationConfig {
  final RevocationRegistryDefinition registryDefinition;
  final RevocationRegistryDefinitionPrivate registryDefinitionPrivate;
  final RevocationStatusList statusList;
  final int registryIndex;

  CredentialRevocationConfig(CredentialRevocationConfigOptions options)
      : registryDefinition = options.registryDefinition,
        registryDefinitionPrivate = options.registryDefinitionPrivate,
        statusList = options.statusList,
        registryIndex = options.registryIndex;

  void clear() {
    registryDefinition.handle.clear();
    registryDefinitionPrivate.handle.clear();
  }

  NativeCredentialRevocationConfig get native {
    return NativeCredentialRevocationConfig(
      revocationRegistryDefinition: registryDefinition.handle,
      revocationRegistryDefinitionPrivate: registryDefinitionPrivate.handle,
      revocationStatusList: statusList.handle,
      registryIndex: registryIndex,
    );
  }
}
