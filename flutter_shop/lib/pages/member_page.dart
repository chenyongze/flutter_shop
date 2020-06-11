import 'package:flutter/material.dart';
import '../config/index.dart';
import 'package:date_format/date_format.dart';

class MemberPage extends StatefulWidget {
  // MemberPage({Key key}) : super(key: key);

  // @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    var abc = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

    return Scaffold(
      appBar: AppBar(title: Text(KString.memberTitle)),
      body: Container(
          child: Column(
        children: [
          Column(
            children: [
              Container(
                child: Text(
                  abc,
                  style: TextStyle(
                    color: Colors.red,
                    // backgroundColor: Colors.yellow,
                  ),
                ),
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: KColor.defaultBorderColor,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              Text('data2'),
            ],
          ),
        ],
      )),
    );
  }
}
