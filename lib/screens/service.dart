import 'package:flutter/material.dart';

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
      body: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 50.0,right: 50.0,top: 20.0),
             child: Text('USER ${widget.nameLoginString}'),
          )
        ],
      ),
    );


      
      
      
  }
}