import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../config/index.dart';
import '../service/http_service.dart';

import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  // @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 防止刷新，保持当前状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("首页刷新...");
  }

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text(KString.homeTitle),
      ),
      body: FutureBuilder(
          future: request('homePageContent', formData: null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              // 轮播
              List<Map> swiperDataList =
                  (data['data']['slides'] as List).cast();
              // 分类
              List<Map> category = (data['data']['category'] as List).cast();
              // 推荐
              List<Map> recomendList =
                  (data['data']['recomend'] as List).cast();
              // 楼层
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              // 广告
              Map fp1 = data['data']['floor1Pic'];
              String title = data['data']['title'];

              print(swiperDataList);
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
                  children: <Widget>[
                    SwiperDiy(
                      swiperDataList: swiperDataList,
                    ),
                    Center(
                      child: Text(title),
                    ),
                  ],
                ),
                loadMore: () async {
                  print("开始加载更多");
                },
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          }),
    );
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {},
              child: Image.network(
                "${swiperDataList[index]['image']}",
                fit: BoxFit.cover,
              ));
        },
        // 图片数量
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
