import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Dialog to receive module data.
class QRReceiverDialog extends StatefulWidget {
  final Function onReceive;

  QRReceiverDialog(this.onReceive);

  @override
  _QRReceiverDialogState createState() => _QRReceiverDialogState();
}

class _QRReceiverDialogState extends State<QRReceiverDialog> {
  String data = "";

  @override
  void initState() {
    Random rnd = Random();
    data = String.fromCharCodes(
        List<int>.generate(5, (i) => (97 + rnd.nextInt(26))));
    setData();
    OSCActions().receiveShared(widget.onReceive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Receive module.', style: Theme.of(context).textTheme.title),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: SizedBox(
            height: 200 + 200 * 0.5 * (SizeScaling.getWidthScaling() - 1),
            width: 200 + 200 * 0.5 * (SizeScaling.getWidthScaling() - 1),
            child: QrImage(
              data: data,
              size: 200 + 200 * 0.8 * (SizeScaling.getWidthScaling() - 1),
            ),
          ),
        ),
      ),
    );
  }

  /// Set data for QR code.
  setData() async {
    data = await GetIp.ipAddress + ',' + data;
    setState(() {});
  }
}
