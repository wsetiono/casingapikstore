import 'package:casingapikstore/models/product.dart';
import 'package:casingapikstore/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductByCategory extends StatefulWidget {
  final Product product;

  ProductByCategory(this.product);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  final oCcy = new NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(product: this.widget.product),
            ),
          );
        },
        child: Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.19,
                child: Image.network(
                    "https://casingapik.com/ecommerce/products/" +
                        widget.product.photo,
                    fit: BoxFit.fill),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.048,
                        child: Text('${this.widget.product.name}')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.024,
                        child:
                            Text('${oCcy.format(this.widget.product.price)}')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
