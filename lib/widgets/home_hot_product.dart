import 'package:casingapikstore/models/selebgramtestimonial.dart';
import 'package:casingapikstore/models/selebgramtestimonial.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeHotProduct extends StatefulWidget {
  final Selebgramtestimonial product;

  HomeHotProduct(this.product);

  @override
  _HomeHotProductState createState() => _HomeHotProductState();
}

class _HomeHotProductState extends State<HomeHotProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Card(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  launch(
                    widget.product.url,
                    universalLinksOnly: true,
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(widget.product.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
