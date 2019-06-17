import 'dart:io';

import 'package:lg_controller/src/osc/OSCMessage.dart';

/// Handles commands to send OSC message.
class OSCSender {
  /// IP address of the LG system.
  final InternetAddress address;

  /// Port address of the LG system.
  final int port;

  OSCSender({this.address, this.port});

  /// Establishes connection and send OSC message.
  void sendModule(OSCMessage message) {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
      final bytes = message.toBytes();
      socket.send(bytes, address, port);
    });
  }
}
