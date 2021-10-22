import 'dart:convert';

import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/models/shipping.dart';
import 'package:ecom_app/models/user.dart';
import 'package:ecom_app/screens/login_screen.dart';
import 'package:ecom_app/services/shipping_service.dart';
import 'package:ecom_app/services/user_service.dart';
import 'package:flutter/material.dart';

import 'payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cartItems;
  CheckoutScreen({this.cartItems});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('checkout'),
        backgroundColor: Colors.redAccent,
        leading: Text(''),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: Text(
                'Shipping Address',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 5.0,
              color: Colors.black,
            ),
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
                controller: address,
                maxLength: 3,
                obscureText: true,
                decoration:
                    InputDecoration(hintText: 'Address', labelText: '*****'),
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
                      var shipping = Shipping();
                      shipping.name = name.text;
                      shipping.email = email.text;
                      shipping.address = address.text;
                      _shipping(context, shipping);
                    },
                    child: Text(
                      'Continue to Paymet',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shipping(BuildContext context, Shipping shipping) async {
    var _shippingService = ShippingService();
    var shippingData = await _shippingService.addShipping(shipping);
    var result = json.decode(shippingData);
    if (result['result'] == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PaymentScreen(cartItems: this.widget.cartItems)));
    }
  }
}

class ShippingService {
  addShipping(Shipping shipping) {}
}
