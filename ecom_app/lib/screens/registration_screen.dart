import 'dart:convert';

import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/models/user.dart';
import 'package:ecom_app/screens/login_screen.dart';
import 'package:ecom_app/services/user_service.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final List<Product> cartItems;
  RegistrationScreen({this.cartItems});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  _register(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.createUser(user);
    var result = json.decode(registeredUser.body);
    if (result['result'] == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['name']);
      _prefs.setString('userEmail', result['user']['email']);
      //  Navigator.push(
      //    context,
      //  MaterialPageRoute(
      //    builder: (context) => CheckoutScreen(cartItems: cartItems)));
    } else {
      _showSnackMessage(Text(
        'failed to registres the user!',
        style: TextStyle(color: Colors.white),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Enter your name', labelText: 'Enter you name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    labelText: 'Enter your email address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter your Password', labelText: '*****'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 30,
                  height: 45.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.redAccent,
                    onPressed: () {
                      var user = User();
                      user.name = name.text;
                      user.email = email.text;
                      user.password = password.text;
                      _register(context, user);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: FittedBox(child: Text('log in to your account')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

mixin SharedPreferences {
  static getInstance() {}

  void setInt(String s, result) {}

  void setString(String s, result) {}

  int getInt(String s) {}
}

class _scaffoldkey {
  static var currentState;
}
