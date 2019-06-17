import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Handles framing of OSC Message.
class OSCMessage {
  /// Path of OSC Message.
  final String path;

  /// Unique id of the LG system.
  final int id;

  /// Encoding parameter for the module type.
  final int encoding;

  /// Module data to be framed as an OSC Message.
  final String data;

  /// Byte form of the data.
  final bytebuilder = new BytesBuilder();

  OSCMessage({this.path, this.id, this.encoding, this.data});

  /// Build the complete OSC Message in the required format.
  List<int> toBytes() {
    bytebuilder.add(addData("/lgcontroller" + path));
    bytebuilder.add(addData(",iis"));
    bytebuilder.add(addInt(id));
    bytebuilder.add(addInt(encoding));
    bytebuilder.add(addData(data));
    return bytebuilder.toBytes();
  }

  /// Convert [data] to the required format for OSC message.
  List<int> addData(String data) {
    List<int> bytes = utf8.encode(data).toList();
    bytes.add(0);
    while (bytes.length % 4 != 0) {
      bytes.add(0);
    }
    return bytes;
  }

  /// Convert [id] to the required format for OSC message.
  List<int> addInt(int id) {
    Uint8List list = new Uint8List(4);
    ByteData byteData = new ByteData.view(list.buffer);
    byteData.setInt32(0, id);
    return list;
  }
}
