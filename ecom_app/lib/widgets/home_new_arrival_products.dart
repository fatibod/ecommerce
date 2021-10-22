import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/widgets/home_new_arrival_product.dart';
import 'package:flutter/material.dart';

class HomeNewArrivalProductsState extends StatefulWidget {
  final List<Product> productList;

  HomeNewArrivalProductsState({this.productList});

  @override
  _HomeNewArrivalProductsStateState createState() =>
      _HomeNewArrivalProductsStateState();
}

class _HomeNewArrivalProductsStateState
    extends State<HomeNewArrivalProductsState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.productList.length,
        itemBuilder: (context, index) {
          return HomeNewArrivalProduct(this.widget.productList[index]);
        },
      ),
    );
  }
}
