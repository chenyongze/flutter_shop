import 'package:flutter/material.dart';
import '../config/index.dart';

class MemberPage extends StatefulWidget {
  // MemberPage({Key key}) : super(key: key);

  // @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(KString.memberTitle)),
      body: Container(
          child: Column(
        children: [],
      )),
    );
  }
}
