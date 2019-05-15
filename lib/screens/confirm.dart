import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../main.dart';
import '../screens/signature.dart';

class Register extends StatefulWidget {
  final Widget child;

  Register({Key key, this.child}) : super(key: key);

  _RegisterState createState() => _RegisterState();

  
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  String nameString = '';
  String licenString = '';
  String transString = '';
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ยืนยันขนส่ง'),
          actions: <Widget>[
            IconButton(
              tooltip: 'Upload To Server',
              icon: Icon(Icons.cloud_upload),
              onPressed: () {
                uploadToServer();
              },
            )
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
                child: licenTextField(),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0,left: 90.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   new Container(
                     margin: EdgeInsets.all(10.0),
                     child: new Image.asset(
                       "images/dhl.png",
                       height: 90.0,
                     ),
                   ),
                    new Container(
                     margin: EdgeInsets.all(10.0),
                     child: new Image.asset(
                       "images/alpha.png",
                       height: 90.0,
                     ),
                   ),
                    
                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 30.0,left: 90.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                     margin: EdgeInsets.all(10.0),
                     child: new Image.asset(
                       "images/kerry.jpg",
                       height: 90.0,
                     ),
                   ),
                   new Container(
                     margin: EdgeInsets.all(10.0),
                     child: new Image.asset(
                       "images/flash.png",
                       height: 90.0,
                     ),
                   )
                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 7.0),
                child: transTextField(),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0,top: 7.0),
                child: nameTextField(),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
                
                child: Row(
                  children: <Widget>[
                    new Expanded(
                      child: signaturepad(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget signaturepad(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      
      color: Colors.blue,
      child: Text(
        'ลายเซนต์',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('your click signature');
        var myRounte = new MaterialPageRoute(
            builder: (BuildContext context) => Signaturpad());
        Navigator.of(context).push(myRounte);
      },
    );
  }

  void uploadToServer() {
    print('You Click Upload');
    // formKey.currentState.reset();
    print(formKey.currentState.validate());
    formKey.currentState.save();
    print('Licen = $licenString, Trans = $transString, Name = $nameString');
    sentNewUserToServer(licenString, transString, nameString);
  }

  void sentNewUserToServer(
      String userLicen, String userTrans, String userName) async {
    String url =
        'http://androidthai.in.th/sun/addUserNich.php?isAdd=true&Licen=$userLicen&Trans=$userTrans&Name=$userName';
    var respone = await get(url);
    var result = json.decode(respone.body);
    print('result ==>$result');
    if (result.toString() == 'true') {
      print('back process');
      Navigator.pop(context);

      // var backRount =new MaterialPageRoute(builder: (BuildContext )=> HomePage());
      // Navigator.of(context).push(backRount);

    }
  }

  Widget licenTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ทะเบียนรถ:',
      ),
      validator: (String value) {
        if (value.length == 0) {
          return 'licen not Blank ?';
        }
      },
      onSaved: (String licen) {
        licenString = licen;
      },
    );
  }

  Widget transTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'ผู้ส่งของ:'),
      validator: (String value) {
        if (value.length == 0) {
          return 'trans not Blank ?';
        }
      },
      onSaved: (String trans) {
        transString = trans;
      },
    );
  }

  Widget nameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'ผู้รับของ:'),
      validator: (String value) {
        if (value.length == 0) {
          return 'Name not Blank ?';
        }
      },
      onSaved: (String name) {
        nameString = name;
      },
    );
  }
}
class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }
  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}