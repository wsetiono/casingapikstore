import 'dart:convert';

import 'package:async/async.dart';
import 'package:casingapikstore/models/category.dart';
import 'package:casingapikstore/models/product.dart';
import 'package:casingapikstore/models/selebgramtestimonial.dart';
import 'package:casingapikstore/models/sliders.dart';
import 'package:casingapikstore/screens/product_search_screen.dart';
import 'package:casingapikstore/services/category_service.dart';
import 'package:casingapikstore/services/product_service.dart';
import 'package:casingapikstore/widgets/home_hot_products.dart';
import 'package:casingapikstore/widgets/home_product_categories.dart';
import 'package:casingapikstore/widgets/product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:casingapikstore/widgets/carousel_slider.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  final drawerItem = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Made By Vincent - Chat", Icons.chat),
    new DrawerItem("__________________", null),
    new DrawerItem("Case iPhone", Icons.category),
    new DrawerItem("Case iPhone + FunPop", Icons.category),
    new DrawerItem("Case AirPod", Icons.category),
    new DrawerItem("Aksesoris", Icons.category),
    new DrawerItem("Strap Apple Watch", Icons.category),
  ];

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FirstFragment();
      case 1:
        // return whatsAppOpenVincent();
        return FlutterOpenWhatsapp.sendSingleMessage("62895403920207",
            "HALLO!%20Selamat%20datang%20di%20Vincent%0AKami%20menyediakan%20jasa%20pembuatan%20website%20dan%20aplikasi%20mobile%20(Android%20/%20iOS).%0A%0AApa%20ada%20hal%20yang%20ingin%20anda%20tanyakan?");

      case 2:
        return new FirstFragment();
      case 3:
        return new ThirdFragment(categoryName: "Case iPhone", categoryId: 1);
      case 4:
        return new FourthFragment(
            categoryName: "Case iPhone + FunPop", categoryId: 2);
      case 5:
        return new FifthFragment(categoryName: "Case AirPod", categoryId: 3);
      case 6:
        return new SixthFragment(categoryName: "Aksesoris", categoryId: 4);
      case 7:
        return new SeventhFragment(
            categoryName: "Strap Apple Watch", categoryId: 40);
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItem.length; i++) {
      var d = widget.drawerItem[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(
          d.icon,
          color: Colors.pink,
        ),
        title: new Text(d.title,
            style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w500)),
        trailing: new Icon(Icons.arrow_right, color: Colors.pink),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(child: Text('Casing Apik')),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150,
              width: 30,
              child: Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      return FlutterOpenWhatsapp.sendSingleMessage(
                          "6289651061361",
                          "HALLO!%20Selamat%20datang%20di%20@CasingApik%0A%0ASEMUA%20case%20yang%20dijual%20READY%20STOCK%20dan%20SIAP%20DIPESAN%20yaa%20:)%0A%0AFORMAT%20PESANAN:%0ANama:%0ANo Hp:%0AAlamat :%0AKecamatan:%0AKota :%0AOrder:%20nama%20case%20/%20warna,%20motif%20/%20tipe%20hp%0A%0ACHECK%20KOLEKSI%20DI%20INSTAGRAM:%20@testingapp%0A%0APengiriman:%0ASENIN-JUMAT%20(closed%20order:%2015:00)%0ASABTU%20:%2013:00)%0ALayanan%20chat:%2010:00%20-%2020:00");
                    },
                    child: new Image(
                      image: new AssetImage("assets/images/whatsapp.png"),
                      width: 30,
                      height: 30,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("Casing Apik",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900)),
              accountEmail: Text("Case iPhone Premium, Aksesoris iPhone",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              decoration: BoxDecoration(
                color: Colors.pink[100],
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.pink[200]
                        : Colors.pink[200],
                child: Image.network(
                    "https://casingapik.com/ecommerce/img/Casing Apik.png"),
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

class FirstFragment extends StatefulWidget {
  @override
  _FirstFragmentState createState() => _FirstFragmentState();
}

class _FirstFragmentState extends State<FirstFragment> {
  TextEditingController etSearch = new TextEditingController();
  String nSearch = "";

  CategoryService _categoryService = CategoryService();

  final AsyncMemoizer<List<Selebgramtestimonial>>
      _memoizerSelebgramTestimonial =
      AsyncMemoizer<List<Selebgramtestimonial>>();
  final AsyncMemoizer<List<Sliders>> _memoizerSlider =
      AsyncMemoizer<List<Sliders>>();
  final AsyncMemoizer<List<Category>> _memoizerTwoFirstCategory =
      AsyncMemoizer<List<Category>>();
  final AsyncMemoizer<List<Category>> _memoizerTwoSecondCategory =
      AsyncMemoizer<List<Category>>();
  final AsyncMemoizer<List<Category>> _memoizerOneLastCategory =
      AsyncMemoizer<List<Category>>();

  var items = [];

  @override
  void initState() {
    super.initState();
    _getAllSliders();
    _getSelebgramTestimonial();
    _getTwoFirstCategories();
    _getTwoSecondCategories();
    _getOneLastCategories();
  }

  Future<List<Category>> _getTwoFirstCategories() async {
    return this._memoizerTwoFirstCategory.runOnce(() async {
      var result = await _categoryService.getTwoFirstCategories();
      List<Category> _categoryList = List<Category>();
      if (result != null) {
        var categories = json.decode(result.body);

        categories['data'].forEach((data) {
          var model = Category();
          model.id = data['id'];
          model.name = data['name'];
          model.image = data['image'];

          _categoryList.add(model);
        });
      }

      return _categoryList;
    });
  }

  Future<List<Category>> _getTwoSecondCategories() async {
    return this._memoizerTwoSecondCategory.runOnce(() async {
      var result = await _categoryService.getTwoSecondCategories();
      List<Category> _categoryList = List<Category>();
      if (result != null) {
        var categories = json.decode(result.body);

        categories['data'].forEach((data) {
          var model = Category();
          model.id = data['id'];
          model.name = data['name'];
          model.image = data['image'];

          // setState(() {
          _categoryList.add(model);
          // });
        });
      }

      return _categoryList;
    });
  }

  Future<List<Category>> _getOneLastCategories() async {
    return this._memoizerOneLastCategory.runOnce(() async {
      var result = await _categoryService.getOneLastCategories();
      List<Category> _categoryList = List<Category>();
      if (result != null) {
        var categories = json.decode(result.body);

        categories['data'].forEach((data) {
          var model = Category();
          model.id = data['id'];
          model.name = data['name'];
          model.image = data['image'];

          // setState(() {
          _categoryList.add(model);
          // });
        });
      }

      return _categoryList;
    });
  }

  Future<List<Selebgramtestimonial>> _getSelebgramTestimonial() async {
    return this._memoizerSelebgramTestimonial.runOnce(() async {
      List<Selebgramtestimonial> _selebgramtestimonialList =
          List<Selebgramtestimonial>();

      // setState(() {
      var model = Selebgramtestimonial();
      model.title = "Amanda Kohar";
      model.url =
          "https://www.instagram.com/s/aGlnaGxpZ2h0OjE3ODYwNDU3NTY5NjYxMzg0?igshid=1ijdqukxvpo01&story_media_id=2218926806927856823_5602325324";
      model.imageUrl = "https://casingapik.com/ecommerce/img/insta-1.jpg";
      _selebgramtestimonialList.add(model);

      model = Selebgramtestimonial();
      model.title = "Review Selebgram";
      model.url =
          "https://www.instagram.com/s/aGlnaGxpZ2h0OjE3ODUxMTU1MTMzNTA1NzE0?igshid=rdb3hlbtm2bb&story_media_id=2107333749934253279_5602325324";
      model.imageUrl = "https://casingapik.com/ecommerce/img/insta-4.jpg";
      _selebgramtestimonialList.add(model);

      model = Selebgramtestimonial();
      model.title = "Testi Customer";
      model.url =
          "https://www.instagram.com/s/aGlnaGxpZ2h0OjE3ODUxMTU1MTMzNTA1NzE0?igshid=2px7spf3q7e9&story_media_id=2341348375567682745_5602325324";
      model.imageUrl = "https://casingapik.com/ecommerce/img/insta-2.jpg";
      _selebgramtestimonialList.add(model);
      // });

      return _selebgramtestimonialList;
    });
  }

  Future<List<Sliders>> _getAllSliders() async {
    return this._memoizerSlider.runOnce(() async {
      List<Sliders> _list = List<Sliders>();

      // setState(() {
      var model = Sliders();
      model.imageUrl =
          "https://casingapik.com/ecommerce/products/1598176013antiknock-candy-case-1.jpg";
      _list.add(model);

      model = Sliders();
      model.imageUrl =
          "https://casingapik.com/ecommerce/products/1598174454wbb-airbag-case-1.jpg";
      _list.add(model);
      // });

      return _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: etSearch,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.pinkAccent, width: 5.0),
                  ),
                  hintText: 'Apa Yang Anda Cari ?',
                  suffixIcon: IconButton(
                    onPressed: () {
                      nSearch = etSearch.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductSearchScreen(searchKeyword: nSearch),
                        ),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),

            FutureBuilder<List<Sliders>>(
              future: _getAllSliders(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Sliders>> snapshot) {
                List<NetworkImage> list = new List<NetworkImage>();
                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data.length; i++) {
                    list.add(NetworkImage(snapshot.data[i].imageUrl));
                  }

                  return carouselSlider(list);
                } else {
                  return Container(
                    child: Text('Loading...'),
                  );
                }
              },
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Selebgram Testimonial'),
            ),

            FutureBuilder<List<Selebgramtestimonial>>(
              future: _getSelebgramTestimonial(),
              builder: (BuildContext context3,
                  AsyncSnapshot<List<Selebgramtestimonial>> snapshot3) {
                if (snapshot3.hasData) {
                  return HomeHotProducts(productList: snapshot3.data);
                } else {
                  return Container(
                    child: Text('Loading...'),
                  );
                }
              },
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Product Categories'),
            ),

            //Letakkan futurebuilder kedua disini untuk mengisikan categoryList
            //Reference : https://gist.github.com/Rahiche/33b488618ab7f7879f645e4a9d2905c6

            FutureBuilder<List<Category>>(
              future: _getTwoFirstCategories(),
              builder: (BuildContext context2,
                  AsyncSnapshot<List<Category>> snapshot2) {
                if (snapshot2.hasData) {
                  return HomeProductCategories(categoryList: snapshot2.data);
                } else {
                  return Container(
                    child: Text('Loading...'),
                  );
                }
              },
            ),

            FutureBuilder<List<Category>>(
              future: _getTwoSecondCategories(),
              builder: (BuildContext context2,
                  AsyncSnapshot<List<Category>> snapshot2) {
                if (snapshot2.hasData) {
                  return HomeProductCategories(categoryList: snapshot2.data);
                } else {
                  return Container(
                    child: Text('Loading...'),
                  );
                }
              },
            ),

            FutureBuilder<List<Category>>(
              future: _getOneLastCategories(),
              builder: (BuildContext context2,
                  AsyncSnapshot<List<Category>> snapshot2) {
                if (snapshot2.hasData) {
                  return HomeProductCategories(categoryList: snapshot2.data);
                } else {
                  return Container(
                    child: Text('Loading...'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdFragment extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  ThirdFragment({this.categoryName, this.categoryId});
  @override
  _ThirdFragmentState createState() => _ThirdFragmentState();
}

class _ThirdFragmentState extends State<ThirdFragment> {
  ProductService _productService = ProductService();

  final AsyncMemoizer<List<Product>> _memoizerProductByCategory =
      AsyncMemoizer<List<Product>>();

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
          model.productDetail = data['description'];

          //https://stackoverflow.com/questions/49340116/setstate-called-after-dispose

          _productListByCategory.add(model);
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

class FourthFragment extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  FourthFragment({this.categoryName, this.categoryId});
  @override
  _FourthFragmentState createState() => _FourthFragmentState();
}

class _FourthFragmentState extends State<FourthFragment> {
  ProductService _productService = ProductService();

  final AsyncMemoizer<List<Product>> _memoizerProductByCategory =
      AsyncMemoizer<List<Product>>();

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
          model.productDetail = data['description'];

          //https://stackoverflow.com/questions/49340116/setstate-called-after-dispose
          // if (this.mounted) {
          //   setState(() {
          _productListByCategory.add(model);
          // });
          // }
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

      // return ProductByCategory(this._productListByCategory[index]);
    );
  }
}

class FifthFragment extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  FifthFragment({this.categoryName, this.categoryId});
  @override
  _FifthFragmentState createState() => _FifthFragmentState();
}

class _FifthFragmentState extends State<FifthFragment> {
  ProductService _productService = ProductService();

  final AsyncMemoizer<List<Product>> _memoizerProductByCategory =
      AsyncMemoizer<List<Product>>();

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
          model.productDetail = data['description'];

          //https://stackoverflow.com/questions/49340116/setstate-called-after-dispose
          // if (this.mounted) {
          //   setState(() {
          _productListByCategory.add(model);
          // });
          // }
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

class SixthFragment extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  SixthFragment({this.categoryName, this.categoryId});
  @override
  _SixthFragmentState createState() => _SixthFragmentState();
}

class _SixthFragmentState extends State<SixthFragment> {
  ProductService _productService = ProductService();

  final AsyncMemoizer<List<Product>> _memoizerProductByCategory =
      AsyncMemoizer<List<Product>>();

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
          model.productDetail = data['description'];

          //https://stackoverflow.com/questions/49340116/setstate-called-after-dispose
          // if (this.mounted) {
          //   setState(() {
          _productListByCategory.add(model);
          //   });
          // }
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

      // return ProductByCategory(this._productListByCategory[index]);
    );
  }
}

class SeventhFragment extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  SeventhFragment({this.categoryName, this.categoryId});
  @override
  _SeventhFragmentState createState() => _SeventhFragmentState();
}

class _SeventhFragmentState extends State<SeventhFragment> {
  ProductService _productService = ProductService();

  final AsyncMemoizer<List<Product>> _memoizerProductByCategory =
      AsyncMemoizer<List<Product>>();

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
          model.productDetail = data['description'];

          //https://stackoverflow.com/questions/49340116/setstate-called-after-dispose
          // if (this.mounted) {
          //   setState(() {
          _productListByCategory.add(model);
          //   });
          // }
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

class SecondFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("Show list photo of category"),
    );
  }
}
