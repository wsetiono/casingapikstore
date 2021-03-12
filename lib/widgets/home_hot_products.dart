import 'package:casingapikstore/models/selebgramtestimonial.dart';
import 'package:casingapikstore/models/selebgramtestimonial.dart';
import 'package:flutter/material.dart';

import 'home_hot_product.dart';

class HomeHotProducts extends StatefulWidget {
  final List<Selebgramtestimonial> productList;
  HomeHotProducts({this.productList});

  @override
  _HomeHotProductsState createState() => _HomeHotProductsState();
}

class _HomeHotProductsState extends State<HomeHotProducts> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            // height: 190,
            height: MediaQuery.of(context).size.height * 0.25,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.productList.length,
              itemBuilder: (context, index) {
                return HomeHotProduct(this.widget.productList[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
