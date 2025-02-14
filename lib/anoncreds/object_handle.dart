import 'register.dart';

class ObjectHandle {
  final int _handle;

  ObjectHandle(this._handle);

  int get handle => _handle;

  int toInt() {
    return _handle;
  }

  String typeName() {
    return anoncreds?.getTypeName(objectHandle: this) ?? '';
  }

  // TODO: do we need this?
  void clear() {
    anoncreds?.objectFree(objectHandle: this);
  }
}
