import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'screens/signature.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
void main() => runApp(MaterialApp(home: QRViewExample()));

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
          // Expanded(          
          //   child: Text("result of scan: $qrText"),
            
          //   //flex: 1,
          // ),
          Container(
            margin: EdgeInsets.only(left: 20.0,top: 40.0,bottom: 40.0),
            child: Row(
              children: <Widget>[
                Text("Tracking : $qrText"),
                RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      color: Colors.orange,
                      textColor: Colors.green,
                      onPressed: () {
                        print('$qrText');
                      },
                      child: signUpButton(context),
                    ),
                    new Text("จำนวน : $_counter")
          //FloatingActionButton(onPressed: signUpButton(context), child: Icon(Icons.save)),
                //Icon(Icons.save)
              ],
              
            ),
          )
        
        ],
      ),
    );
  }

Widget signUpButton(BuildContext context) {
    return RaisedButton(
      color: Colors.green,
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
           sendtoserver(this.qrText);
          setState(() {
            
            qrText = arguments.toString();
            _counter++;
          }
          
          );
      }
    });
  }

//   void _incrementCounter() {
//   setState(() {
//     _counter++;
//   });
// }

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
