import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/screens/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/screens/products_by_category_screens.dart';

class ProductByCategory extends StatefulWidget {
  final Product product;
  final String productName;
  final String productPhoto;
  final double productPrice;
  final double productDiscount;
  ProductByCategory(this.product, this.productName, this.productPhoto,
      this.productPrice, this.productDiscount);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 190,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetail(
                        this.widget.product,
                      )));
        },
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: <Widget>[
                              Text(this.widget.productName),
                              Image.network(
                                widget.productPhoto,
                                width: 190.0,
                                height: 160.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Price : ${this.widget.productPrice}'),
                                  Text(
                                      'Discount :${this.widget.productDiscount}'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
