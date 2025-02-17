import 'package:anoncreds_wrapper_dart/anoncreds/exceptions.dart';
import 'package:anoncreds_wrapper_dart/anoncreds/register.dart';

class ObjectHandle {
  final int handle;

  ObjectHandle(this.handle);

  String typeName() {
    try {
      return anoncreds.objectGetTypeName(this).getValueOrException();
    } catch (e) {
      throw AnoncredsException('Failed to get type name');
    }
  }

  void clear() {
    try {
      return anoncreds.objectFree(this);
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
