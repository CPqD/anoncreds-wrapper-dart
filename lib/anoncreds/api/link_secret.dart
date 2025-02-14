import '../register.dart';

class LinkSecret {
  static String create() {
    return anoncreds?.createLinkSecret() ?? '';
  }
}
