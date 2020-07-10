import 'package:flutter/material.dart';
import '../config/index.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class CartPage extends StatefulWidget {
  // CartPage({Key key}) : super(key: key);
  // @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text(KString.shoppingCartTitle)),
    //   body: Container(
    //       child: Column(
    //     children: [],
    //   )),
    // );

    String debugLable = 'Unknown'; //错误信息
    final JPush jpush = new JPush(); //初始化极光插件

    return new Scaffold(
      appBar: new AppBar(
        title: Text(KString.shoppingCartTitle),
      ),
      body: new Center(
          child: new Column(children: [
        new Text('结果: $debugLable\n'),
        new FlatButton(
            child: new Text('发送推送消息\n'),
            onPressed: () {
              // 三秒后出发本地推送
              var fireDate = DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch + 3000);
              var localNotification = LocalNotification(
                id: 234,
                title: '技术胖的飞鸽传说',
                buildId: 1,
                content: '看到了说明已经成功了',
                fireTime: fireDate,
                subtitle: '一个测试',
              );
              jpush.sendLocalNotification(localNotification).then((res) {
                setState(() {
                  debugLable = res;
                });
              });
            }),
      ])),
    );
  }
}
