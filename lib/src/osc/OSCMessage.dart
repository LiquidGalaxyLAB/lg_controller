import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:lg_controller/src/osc/ModuleType.dart';

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

  /// Convert integer from byte list.
  int getInt(List<int> value) {
    final buffer = Uint8List.fromList(value).buffer;
    final byteData = new ByteData.view(buffer);
    return byteData.getInt32(0);
  }

  /// Decode the complete OSC message in required format.
  static OSCMessage fromBytes(List<int> bytes) {
    try {
      String path = utf8.decode(bytes.sublist(0, bytes.indexOf(0)));
      ModuleType mod = ModuleType.SHARE;
      if (path.compareTo("/lgcontroller" + mod.path) != 0) return null;
      int shift = bytes.indexOf(0);
      bytes =
          bytes.sublist(shift + ((shift % 4 == 0) ? 0 : 4 - (shift % 4)) + 1);
      String key = utf8.decode(bytes.sublist(0, bytes.indexOf(0)));
      if (key.compareTo("iis") != 0) return null;
      shift = bytes.indexOf(0);
      bytes = bytes.sublist(shift);
      int id = ByteData.view(Uint8List.fromList(bytes.sublist(0, 8)).buffer)
          .getInt32(0);
      int enc = ByteData.view(Uint8List.fromList(bytes.sublist(8, 12)).buffer)
          .getInt32(0);
      if (enc != mod.encoding) return null;
      bytes = bytes.sublist(12);
      String data = utf8.decode(bytes);
      return OSCMessage(path: path, id: 0, encoding: mod.encoding, data: data);
    } catch (e) {
      return null;
    }
  }
}
