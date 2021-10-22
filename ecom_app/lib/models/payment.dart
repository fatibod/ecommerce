import 'dart:convert';

import 'package:ecom_app/models/product.dart';

class Payment {
  int id;
  String name;
  String email;
  String cardNumber;
  String expriryMonth;
  String expriryYear;
  String cvnNumber;
  int userId;
  List<Product> cartItems;

  toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'email': email,
      'cardNumber': cardNumber,
      'expriryMonth': expriryMonth,
      ' expriryYear': expriryYear,
      'cvnNumber': cvnNumber,
      'cartItems': json.encoder.convert(cartItems)
    };
  }
}
