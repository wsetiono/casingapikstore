import 'package:casingapikstore/models/category.dart';
import 'package:casingapikstore/widgets/home_product_category.dart';
import 'package:flutter/material.dart';

class HomeProductCategories extends StatefulWidget {
  final List<Category> categoryList;
  HomeProductCategories({this.categoryList});

  @override
  _HomeProductCategoriesState createState() => _HomeProductCategoriesState();
}

class _HomeProductCategoriesState extends State<HomeProductCategories> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.37,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.categoryList.length,
              itemBuilder: (context, index) {
                return HomeProductCategory(
                    this.widget.categoryList[index].image,
                    this.widget.categoryList[index].name,
                    this.widget.categoryList[index].id);
              },
            ),
          ),
        ),
      ],
    );
  }
}
