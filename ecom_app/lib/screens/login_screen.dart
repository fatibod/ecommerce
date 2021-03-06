import 'dart:convert';

import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/models/user.dart';
import 'package:ecom_app/screens/registration_screen.dart';
import 'package:ecom_app/services/user_service.dart';
import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class LoginScreen extends StatefulWidget {
  final List<Product> cartItems;
  LoginScreen({this.cartItems});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  get cartItems => null;

  _login(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.login(user);
    print(registeredUser.body);
    var result = json.decode(registeredUser.body);

    if (result['result'] == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['name']);
      _prefs.setString('userEmail', result['user']['email']);
      var cartItems;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(cartItems: cartItems)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(cartItems: cartItems)));
    }
  }
}

@override
Widget build(BuildContext context) {
  var email;
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
            })
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
                  hintText: 'youremail@example.com',
                  labelText: 'Enter your email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
            child: TextField(
              controller: email,
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
                    user.email = email.text;
                    var password;
                    user.password = password.text;
                    _login(context, user);
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen(
                                cartItems: this.widget.cartItems,
                              )));
                },
                child: FittedBox(child: Text('Register your account')),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


