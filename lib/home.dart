import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'screens/confirm.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
//void main() => runApp(MaterialApp(home: QRViewExample()));

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,

  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  int _counter = 0;
  List<String> tracking=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: const Text('Counter example'),
        ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
            flex: 4,
          ),
          Container(
            margin: EdgeInsets.only(top: 7.0,bottom: 7.0),
            child: Text(("Tracking : $qrText"),style: TextStyle(fontSize: 18.0),)

          ),
          
                Container(
                  margin: EdgeInsets.only(top: 7.0,bottom: 7.0),
child: new Text(("จำนวน : $_counter"),style: TextStyle(fontSize: 18.0))
                ),
                  Container(
                    margin: EdgeInsets.only(top: 7.0,bottom: 7.0),
child: saveButton(context)
                  )  
                   
          
              ], 
            ),
          
      );
      
  }

Widget saveButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('your click SignIn');
        var myRounte = new MaterialPageRoute(
            builder: (BuildContext context) => Register());
        Navigator.of(context).push(myRounte);
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final channel = controller.channel;
    controller.init(qrKey);
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "onRecognizeQR":
          dynamic arguments = call.arguments;
                  setState(() {
                      qrText = arguments.toString();
                      //if(qrText.toUpperCase().contains("TDZ")){}
                      //_counter++;
                    });
                 if(!tracking.contains(this.qrText)){
                    tracking.add(this.qrText);
                    sendtoserver(this.qrText);
                    setState(() {
                      //qrText = arguments.toString();
                      _counter++;
                    });
                }else{
                    print('+++++++++++++++++++++++');
                    print('Duplicated No.');
                      print('+++++++++++++++++++++++');
                }

      }
      }
    );
    
  }


  Future sendtoserver(data) async {
    print('============');
    print(data);
    print('rrrr');
    print('============');

    var url = 'http://androidthai.in.th/sun/addDataOill.php';
    var response =
        await http.post(url, body: {'isAdd': 'true', 'Barcode': data});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
