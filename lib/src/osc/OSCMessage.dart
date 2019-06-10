import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class OSCMessage {
  final String path;
  final int id;
  final int encoding;
  final String data;
  final bytebuilder = new BytesBuilder();

  OSCMessage({this.path, this.id, this.encoding, this.data});

  List<int> toBytes() {
    bytebuilder.add(addData("/lgcontroller" + path));
    bytebuilder.add(addData(",iis"));
    bytebuilder.add(addInt(id));
    bytebuilder.add(addInt(encoding));
    bytebuilder.add(addData(data));
    return bytebuilder.toBytes();
  }

  List<int> addData(String data) {
    List<int> bytes = utf8.encode(data).toList();
    bytes.add(0);
    while (bytes.length % 4 != 0) {
      bytes.add(0);
    }
    return bytes;
  }

  List<int> addInt(int id) {
    Uint8List list = new Uint8List(4);
    ByteData byteData = new ByteData.view(list.buffer);
    byteData.setInt32(0, id);
    return list;
  }
}
