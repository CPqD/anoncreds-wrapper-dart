import 'dart:typed_data';

class ByteBufferOptions {
  final int len;
  final Uint8List data;

  ByteBufferOptions({required this.len, required this.data});
}

class ByteBuffer {
  final int len;
  final Uint8List data;

  ByteBuffer({required this.data, required this.len});

  factory ByteBuffer.fromUint8List(Uint8List data) {
    return ByteBuffer(data: data, len: data.length);
  }
}

typedef JsonObject = Map<String, dynamic>;
