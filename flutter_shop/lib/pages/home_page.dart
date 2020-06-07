import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/config/index.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  // @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text(KString.homeTitle),
      ),
      body: FutureBuilder(builder: (context, snapshot) {
        print('home ...start');
        return EasyRefresh(
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            bgColor: Colors.white,
            textColor: KColor.refreshTextColor,
            moreInfoColor: KColor.refreshTextColor,
            showMore: true,
            noMoreText: '',
            moreInfo: KString.loading,
            loadReadyText: KString.loadReadyText,
          ),
          child: ListView(
            children: <Widget>[],
          ),
          loadMore: ()async{
            print("开始加载更多");
          },
        );
      }),
    );
  }
}
