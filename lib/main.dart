import 'package:flutter/material.dart';
import 'screens/confirm.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import './models/json_model.dart';
import './screens/service.dart';
import './home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sun Authen',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  String emailString, passwordString, nameString, truePassword, idString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60.0),height: 250.0,
                child: logoShow(),
              ),
              
              Container(
                alignment: Alignment.center,margin: EdgeInsets.only(top: 100.0,bottom: 20.0),
                child: titleApp(),
              ),
              Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 20.0,bottom: 20.0),
            child: new TextField(
              //controller: Text('data'),
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white)),
                  //hintText: 'Enter your phone number',
                  labelText: 'Enter your phone number',
                  labelStyle: new TextStyle(fontSize: 18.0),
                  prefixIcon: const Icon(
                  Icons.phone_android,
                  color: Colors.blueAccent,
                  ),
                  ),


            ),


          ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 40.0,top: 30.0),
                child: Row(
                  children: <Widget>[
                    new Expanded(
                      child: signInButton(context),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 40.0,top: 2.0),
                child: Row(
                  children: <Widget>[
                    new Expanded(
                      child: signUpButton(context),
                    ),
                  ],
                ),
              )
            ],
          ),
          
        ));
  }

  Widget testText() {
    return Text('textText');
  }

  Widget logoShow() {
    return Image.asset('images/logostart.png');
  }

  Widget titleApp() {
    return Text(
      'Enter your Phone number',
    
      style: TextStyle(
        fontSize: 18.0,
        fontFamily: 'Kanit-Bold',
        fontWeight: FontWeight.bold,
        color: Colors.blue[800],
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address:', border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0))),
  
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'Password:',
           hintText: 'more 5 Charactor', border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0))),
      validator: (String value) {
        if (value.length <= 5) {
          return 'กรอกใหม่ซิ !';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        'LOGIN',
        style: new TextStyle(fontSize: 18.0 ,color: Colors.white.withOpacity(1.0)),
                  textAlign: TextAlign.center,
      ),
      onPressed: () {
        print('your click SignUp');
        //print(formKey.currentState.validate());
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          checkEmailAndPass(context, emailString, passwordString);
        }
      },
    );
  }

  void checkEmailAndPass(
      BuildContext context, String email, String password) async {
    print('email ==>$email,password==>$password');

    String urlString =
        'http://androidthai.in.th/sun/getUserWhereUserOil.php?isAdd=true&User=$email';
    var response = await get(urlString);
    var result = json.decode(response.body);
    print('result==>$result');
    if (result.toString() == 'null') {
      showSnackBar('User fail');
    } else {
      for (var data in result) {
        print('data==>$data');
        var jsonModel = JsonModel.fromJson(data);

        truePassword = jsonModel.password.toString();
        nameString = jsonModel.name.toString();
        idString = jsonModel.id.toString();

        print(
            'id==>$idString, nameString==>$nameString,truePassword ==>$truePassword');
      }
      if (passwordString == truePassword) {
        showSnackBar('USER : $nameString');

        var serviceRoute =
            new MaterialPageRoute(builder: (BuildContext context) => Service(nameLoginString: nameString,));
        Navigator.of(context).push(serviceRoute);

      } else {
        showSnackBar('ออกไปซะ !!');
      }
    } //if
  }

  void showSnackBar(String messageString) {
    final snackBar = new SnackBar(
      content: Text(messageString),
      backgroundColor: Colors.orange[200],
      duration: new Duration(seconds: 4),
      action: new SnackBarAction(
        label: 'Please Click',
        onPressed: () {
          print('You Click SnackBare');
        },
      ),
    );
    _scaffold.currentState.showSnackBar(snackBar);
  }

  Widget signUpButton(BuildContext context) {
    return RaisedButton(
      color: Colors.orange,
      child: Text(
        'Scan',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('your click Scan');
        var myRounte = new MaterialPageRoute(
            builder: (BuildContext context) => QRViewExample());
        Navigator.of(context).push(myRounte);
      },
    );
  }
} //_HomePageState
