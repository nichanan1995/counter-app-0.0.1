import 'package:flutter/material.dart';
import '../home.dart';

class Service extends StatefulWidget {

  final String nameLoginString;


  Service({Key key, this.nameLoginString}) : super(key: key);

  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.nameLoginString}'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 50.0,right: 50.0,top: 20.0),
             child: Text('USER ${widget.nameLoginString}'),
          ),
          Container(
            margin: EdgeInsets.only(left: 50.0,right: 50.0,top: 20.0),
             child: scanQR(context),
          ),
        ],
      ),  
    );
  }
}


Widget scanQR(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        'Scan',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('your click SignIn');
        var myRounte = new MaterialPageRoute(
            builder: (BuildContext context) => QRViewExample());
        Navigator.of(context).push(myRounte);
      },
    );
  }