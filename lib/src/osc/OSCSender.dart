import 'dart:io';

import 'package:lg_controller/src/osc/OSCMessage.dart';

class OSCSender {
  final InternetAddress address;
  final int port;

  OSCSender({this.address, this.port});

  void sendModule(OSCMessage message) {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
      final bytes = message.toBytes();
      socket.send(bytes, address, port);
    });
  }
}
