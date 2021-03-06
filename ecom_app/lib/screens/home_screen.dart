import 'dart:convert';

import 'package:ecom_app/models/category.dart';
import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/screens/cart_screens.dart';
import 'package:ecom_app/services/cart_service.dart';
import 'package:ecom_app/services/category_service.dart';
import 'package:ecom_app/services/product_service.dart';
import 'package:ecom_app/services/slider_service.dart';
import 'package:ecom_app/widgets/carousel_slider.dart';
import 'package:ecom_app/widgets/home_hot_products.dart';
import 'package:ecom_app/widgets/home_new_arrival_product.dart';
import 'package:ecom_app/widgets/home_product_categories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  SliderService _sliderService = SliderService();
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();

  List<Category> _categoryList = List<Category>();
  List<Product> _productList = List<Product>();
  List<Product> _newArrivalproductList = List<Product>();

  CartService _cartService = CartService();
  List<Product> _cartItems;

  
  var items = [];

  @override
  void initState() {
    super.initState();
    _getAllSliders();
    _getAllCategories();
    _getAllHotProducts();
    _getAllNewArrivalProducts();
    _getCartItems();
  }

   _getCartItems() async {
    _cartItems = List<Product>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data) {
      var product = Product();
      product.id = data['productId'];
      product.name = data['productName'];
      product.photo = data['productPhoto '];
      product.price = data['productPrice'];
      product.discount = data['productDiscount'];
      product.productDetail = data['productDetail'] ?? 'NO DETAIL';
      product.quantity = data['productQuantity'];

      setState(() {
        _cartItems.add(product);
      });
    });
  }

  _getAllSliders() async {
    var sliders = await _sliderService.getSliders();
    var result = json.decode(sliders.body);
    result['data'].forEach((data) {
      setState(() {
        items.add(NetworkImage(data['image_url']));
      });
    });
    print(result);
  }

  _getAllCategories() async {
    var categories = await _categoryService.getCategories();
    var result = json.decode(categories.body);
    result['data'].forEach((data) {
      var model = Category();
      model.id = data['id'];
      model.name = data['categoryName'];
      model.icon = data['categoryIcon'];
      setState(() {
        _categoryList.add(model);
      });
    });
  }

  _getAllHotProducts() async {
    var hotProducts = await _productService.getHotProducts();
    var result = json.decode(hotProducts.body);
    result['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['detail'];

      setState(() {
        _productList.add(model);
      });
    });
  }

    }

  _getAllNewArrivalProducts() async {
    var newArrivalProducts = await _productService.getnewArrivalProducts();
    var result = json.decode(newArrivalProducts.body);
    result['data'].forEach((data) {
    var model = Product();
    model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];

      setState(() {
      var _newArrivalproductList;
      _newArrivalproductList.add(model);
      });
    });
  }

void setState(Null Function() param0) {
}

class _productService {
  static getnewArrivalProducts() {}
}

  @override
  Widget build(BuildContext context) {
    var _cartItems;
    var items= items;
    var categoryList = _categoryList;
  

    return Scaffold(
      appBar: AppBar(
        title: Text('eComm App'),
        backgroundColor:  Colors.redAccent,
         actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(_cartItems)));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                width: 30,
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                        child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_1,
                          size: 25,
                          color: Colors.black,
                        ),
                        Positioned(
                          top: 4.0,
                          right: 8.0,
                          child:
                              Center(child: Text(_cartItems.length.toString())),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          carouselSlider(items4),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('product Categories'),
          ),
          HomeProductCategories(
            categpryList: categoryList,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(' Hot products'),
          ),
          HomeHotProducts(productList: productList2),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(' New Arrival Products'),
          ),
          HomeNewArrivalProduct(productList: _newArrivalproductList),
        ],
      )),
    );
  }
}


