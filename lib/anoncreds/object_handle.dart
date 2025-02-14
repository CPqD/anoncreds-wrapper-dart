import 'package:anoncreds_wrapper_dart/anoncreds/bindings/anoncreds_wrapper.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';

class ObjectHandle {
  final int handle;

  ObjectHandle(this.handle);

  String typeName() {
    try {
      return anoncredsObjectGetTypeName(this).getValueOrException();
    } catch (e) {
      throw AnoncredsException('Failed to get type name');
    }
  }

  void clear() {
    try {
      return anoncredsObjectFree(this);
    } catch (e) {
      throw AnoncredsException('Failed to free object');
    }
  }

  int toInt() {
    return handle;
  }

  @override
  String toString() {
    return "ObjectHandle($handle)";
  }
}
