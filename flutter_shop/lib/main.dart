import 'package:flutter/material.dart';
import 'config/index.dart';
import './provide/current_index_provide.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();

  providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
}

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
