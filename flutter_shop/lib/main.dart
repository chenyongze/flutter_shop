import 'package:flutter/material.dart';
import 'config/index.dart';
import './provide/current_index_provide.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();

  providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
}

class MMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: KString.mainTitle,
        debugShowCheckedModeBanner: false,
        // 定制主题
        theme: ThemeData(
          primaryColor: KColor.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: IndexPage(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String debugLable = 'Unknown'; //错误信息
  final JPush jpush = new JPush(); //初始化极光插件
  @override
  void initState() {
    super.initState();
    initPlatformState(); //极光插件平台初始化
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      //监听响应方法的编写
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
        setState(() {
          debugLable = "接收到推送: $message";
        });
      });
    } on PlatformException {
      platformVersion = '平台版本获取失败，请检查！';
    }

    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

// 编写视图
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: MaterialApp(
        title: KString.mainTitle,
        debugShowCheckedModeBanner: false,
        // 定制主题
        theme: ThemeData(
          primaryColor: KColor.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: IndexPage(),
      ),
    );
  }
}
