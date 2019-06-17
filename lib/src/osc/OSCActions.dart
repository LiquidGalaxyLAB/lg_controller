import 'dart:io';

import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCMessage.dart';
import 'package:lg_controller/src/osc/OSCSender.dart';

/// Handles OSC Actions of the app.
class OSCActions {
  /// [OSCSender] instance to send OSC Message.
  OSCSender sender;

  /// Send module [data] as an OSC Message.
  void sendModule(ModuleType modtype, String data) {
    initializeOSC();
    final message = new OSCMessage(
        path: modtype.path,
        id: getUniqueId(),
        encoding: modtype.encoding,
        data: data);
    sender.sendModule(message);
  }

  /// Initialize OSC sender instance.
  initializeOSC() {
    if (sender == null)
      sender = OSCSender(address: InternetAddress("192.168.43.84"), port: 3000);
  }

  /// To get unique id of the associated LG system.
  int getUniqueId() {
    return 12345;
  }
}
