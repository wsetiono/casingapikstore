import 'dart:async';
import 'dart:convert';

import 'package:casingapikstore/models/product.dart';
import 'package:casingapikstore/services/product_service.dart';
import 'package:casingapikstore/widgets/product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  ProductsByCategoryScreen({this.categoryName, this.categoryId});
  @override
  _ProductsByCategoryScreenState createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  ProductService _productService = ProductService();

  final AsyncMemoizer<List<Product>> _memoizerProductByCategory =
      AsyncMemoizer<List<Product>>();

  // Timer timer;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Product>> _getProductsByCategory() async {
    return this._memoizerProductByCategory.runOnce(() async {
      var products =
          await _productService.getProductsByCategoryId(this.widget.categoryId);
      List<Product> _productListByCategory = List<Product>();

      if (products != null) {
        var _list = json.decode(products.body);
        _list['data'].forEach((data) {
          var model = Product();
          model.id = data['id'];
          model.name = data['name'];
          model.photo = data['image'];
          model.price = data['price'];
          // model.discount = data['discount'];
          model.productDetail = data['description'];

          //https://stackoverflow.com/questions/49340116/setstate-called-after-dispose
          if (this.mounted) {
            setState(() {
              _productListByCategory.add(model);
            });
          }
        });
      }

      return _productListByCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.categoryName),
        backgroundColor: Colors.pink[100],
      ),
      body: FutureBuilder<List<Product>>(
        future: _getProductsByCategory(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ProductByCategory(snapshot.data[index]);
                },
              ),
            );
          } else {
            return Container(
              child: Text('Loading...'),
            );
          }
        },
      ),
    );
  }
}
