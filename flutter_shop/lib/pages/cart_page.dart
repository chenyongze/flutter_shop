import 'package:flutter/material.dart';
import '../config/index.dart';

class CartPage extends StatefulWidget {
  // CartPage({Key key}) : super(key: key);

  // @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(KString.shoppingCartTitle)),
      body: Container(
          child: Column(
        children: [],
      )),
    );
  }
}
