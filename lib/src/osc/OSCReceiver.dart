import 'dart:io';

import 'package:lg_controller/src/osc/OSCMessage.dart';

/// Handle OSC Receiver on the app.
class OSCReceiver {
  /// IP address of the LG system.
  final InternetAddress address;

  /// Port address of the LG system.
  final int port;

  OSCReceiver({this.address, this.port});

  /// Establishes connection and receives OSC message.
  void receiveModule(Function onReceive) {
    RawDatagramSocket.bind(address, port).then((socket) {
      socket.listen((e) {
        final datagram = socket.receive();
        if (datagram != null) {
          final msg = OSCMessage.fromBytes(datagram.data);
          if (msg != null && msg.data != null) {
            onReceive(msg.data);
          } else {
            onReceive(null);
          }
          socket.close();
        }
      });
    });
  }
}
