import 'package:flutter/material.dart';
import 'config/index.dart';
import './provide/current_index_provide.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
// import './pages/alipay_page.dart';
// import './pages/wechat_page.dart';
// import './pages/jpush_page.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();

  providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runZoned(() {
    runApp(ProviderNode(
      providers: providers,
      child: MyApp(),
    ));
  }, onError: (Object error, StackTrace stack) {
    print(error);
    print(stack);
  });

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

// 正式接入
class MyApp extends StatelessWidget {
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
