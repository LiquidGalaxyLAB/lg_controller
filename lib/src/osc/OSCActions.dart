import 'dart:io';

import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCMessage.dart';
import 'package:lg_controller/src/osc/OSCSender.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Handles OSC Actions of the app.
class OSCActions {
  /// [OSCSender] instance to send OSC Message.
  OSCSender sender;

  /// Send module [data] as an OSC Message.
  Future<void> sendModule(ModuleType modtype, String data) async {
    await initializeOSC();
    final message = new OSCMessage(
        path: modtype.path,
        id: await getUniqueId(),
        encoding: modtype.encoding,
        data: data);
    sender.sendModule(message);
  }

  /// Initialize OSC sender instance.
  initializeOSC() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (sender == null)
      sender = OSCSender(
          address: InternetAddress(prefs.getString('ip')),
          port: prefs.getInt('socket'));
  }

  /// To get unique id of the associated LG system.
  Future<int> getUniqueId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }
}
