import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';
import 'package:toast/toast.dart';

/// Dialog to request OSC params.
class QRSenderDialog extends StatefulWidget {

  final String data;
  QRSenderDialog(this.data);

  @override
  _QRSenderDialogState createState() => _QRSenderDialogState();
}

class _QRSenderDialogState extends State<QRSenderDialog> {

  String data="";

  @override
  void initState() {
    scan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sending..',
          style: Theme.of(context).textTheme.title),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String data = await BarcodeScanner.scan();
      setState(() => this.data = data);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.data = "";
        });
      } else {
        setState(() => this.data = "");
      }
    } on FormatException{
      setState(() => this.data = "");
    } catch (e) {
      setState(() => this.data = "");
    }
    if(this.data.compareTo("")==0)
      Navigator.of(context).pop();
    else
      sendModule();
  }
  sendModule() async{
    data=data.split(',')[0];
    if(!validIP(data))
      {
        Navigator.of(context).pop();
        Toast.show(
          'Invalid receiver.',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        return;
      }
    await OSCActions().shareModule(data, widget.data);
    Navigator.of(context).pop();
    Toast.show(
      'Module sent successfully.',
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }
  bool validIP(String data)
  {
    List<String> val = data.split('.');
    if(val.length!=4)
      return false;
    try{
      for(var i in val)
        if(int.parse(i)<0 || int.parse(i)>255)
          return false;
    }
    catch(e)
    {
      return false;
    }
    return true;
  }
}
