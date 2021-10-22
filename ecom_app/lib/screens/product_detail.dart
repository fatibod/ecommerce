import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/screens/cart_screens.dart';
import 'package:ecom_app/services/cart_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail(this.product);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();
  List<Product> _cartItems;

  @override
  void initState() {
    super.initState();
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

  _addToCart(BuildContext context, Product product) async {
    var result = await _cartService.addToCart(product);

    if (result > 0) {
      _getCartItems();
      _showSnackMessage(Text(
        'item added to card successfullly',
        style: TextStyle(color: Colors.white),
      ));
    } else {
      _showSnackMessage(Text(
        'Failed to add to card',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffolKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.product.name),
        backgroundColor: Colors.redAccent,
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
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  child: Image.network(this.widget.product.photo),
                ),
              ),
              footer: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Container(
                  child: ListTile(
                      leading: Text(
                        this.widget.product.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            'Price : ${this.widget.product.price - this.widget.product.discount}',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                          Expanded(
                              child: Text(
                            'Discount :${this.widget.product.price}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough),
                          )),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  _addToCart(context, this.widget.product);
                },
                textColor: Colors.redAccent,
                child: Row(
                  children: <Widget>[
                    Text('Add to cart'),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
              title: Text(
                'product delaite',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(this.widget.product.productDetail),
            ),
          )
        ],
      ),
    );
  }
}
