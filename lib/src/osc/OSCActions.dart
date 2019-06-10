import 'dart:io';

import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCMessage.dart';
import 'package:lg_controller/src/osc/OSCSender.dart';

class OSCActions {
  OSCSender sender;

  void sendModule(ModuleType modtype, String data) {
    initializeOSC();
    final message = new OSCMessage(
        path: modtype.path,
        id: getUniqueId(),
        encoding: modtype.encoding,
        data: data);
    sender.sendModule(message);
  }

  initializeOSC() {
    if (sender == null)
      sender = OSCSender(address: InternetAddress("192.168.43.84"), port: 3000);
  }

  int getUniqueId() {
    return 12345;
  }
}
