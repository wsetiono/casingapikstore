import 'dart:convert';

import 'package:casingapikstore/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter/services.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final oCcy = new NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0);
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // void whatsAppOpentestingapp() async {
  //   await FlutterLaunch.launchWathsApp(
  //       phone: "6289651061361",
  //       message:
  //           "HALLO!%20Selamat%20datang%20di%20@testingapp%0A%0ASEMUA%20case%20yang%20dijual%20READY%20STOCK%20dan%20SIAP%20DIPESAN%20yaa%20:)%0A%0AFORMAT%20PESANAN:%0ANama:%0ANo Hp:%0AAlamat :%0AKecamatan:%0AKota :%0AOrder:%20nama%20case%20/%20warna,%20motif%20/%20tipe%20hp%0A%0ACHECK%20KOLEKSI%20DI%20INSTAGRAM:%20@testingapp%0A%0APengiriman:%0ASENIN-JUMAT%20(closed%20order:%2015:00)%0ASABTU%20:%2013:00)%0ALayanan%20chat:%2010:00%20-%2020:00");
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(this.widget.product.name),
        backgroundColor: Colors.pink[100],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            // height: 300,
            height: MediaQuery.of(context).size.height * 0.35,

            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Image.network(
                    "https://casingapik.com/ecommerce/products/" +
                        this.widget.product.photo,
                  ),
                ),
              ),
              footer: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              '${this.widget.product.name}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '${oCcy.format(this.widget.product.price)}',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // whatsAppOpentestingapp();
                      FlutterOpenWhatsapp.sendSingleMessage("6289651061361",
                          "HALLO!%20Selamat%20datang%20di%20@CasingApik%0A%0ASEMUA%20case%20yang%20dijual%20READY%20STOCK%20dan%20SIAP%20DIPESAN%20yaa%20:)%0A%0AFORMAT%20PESANAN:%0ANama:%0ANo Hp:%0AAlamat :%0AKecamatan:%0AKota :%0AOrder:%20nama%20case%20/%20warna,%20motif%20/%20tipe%20hp%0A%0ACHECK%20KOLEKSI%20DI%20INSTAGRAM:%20@testingapp%0A%0APengiriman:%0ASENIN-JUMAT%20(closed%20order:%2015:00)%0ASABTU%20:%2013:00)%0ALayanan%20chat:%2010:00%20-%2020:00");
                    },
                    child: Card(
                      color: Colors.green[400],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            new Image(
                              image:
                                  new AssetImage("assets/images/whatsapp.png"),
                              width: 30,
                              height: 30,
                              color: null,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),
                            Text(
                              'Hubungi Kami',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
                title: Text(
                  'Product detail',
                  style: TextStyle(fontSize: 20),
                ),
                // subtitle: Text(this.widget.product.productDetail),
                subtitle: SingleChildScrollView(
                  // child: Text(this.widget.product.productDetail),
                  child: HtmlWidget(this.widget.product.productDetail),
                )),
          ),
        ],
      ),
    );
  }
}
