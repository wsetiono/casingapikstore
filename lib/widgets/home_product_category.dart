import 'package:casingapikstore/screens/products_by_category_screen.dart';
import 'package:flutter/material.dart';

class HomeProductCategory extends StatefulWidget {
  final int categoryId;
  final String categoryImage;
  final String categoryName;
  HomeProductCategory(this.categoryImage, this.categoryName, this.categoryId);

  @override
  _HomeProductCategoryState createState() => _HomeProductCategoryState();
}

class _HomeProductCategoryState extends State<HomeProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsByCategoryScreen(
                  categoryName: widget.categoryName,
                  categoryId: widget.categoryId),
            ),
          );
        },
        child: Card(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                  "https://casingapik.com/ecommerce/categories/" +
                      widget.categoryImage,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.categoryName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
