import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/repository/repository.dart';

import 'package:ecom_app/repository/repository.dart';
import 'package:flutter/material.dart';

class CartService {
  Repository _repository;

  CartService() {
    _repository = Repository();
  }

  addToCart(Product product) async {
    List<Map> items =
        await _repository.getLocalByCondition('carts', 'productId', product.id);
    if (items.length > 0) {
      product.quantity = items.first['productQuantity'] + 1;
      return await _repository.updateLocal(
          'carts', 'productId', product.toMap());
    }
    product.quantity = 1;
    return await _repository.saveLocal('carts', product.toMap());
  }

  void deleteCartItemById(int id) {}

  getCartItems() {}
}
