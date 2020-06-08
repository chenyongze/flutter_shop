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
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              // 推荐
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
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
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    RecommendUI(
                      recommendList: recommendList,
                    ),
                    FloorPic(
                      floorPic: fp1,
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
              onTap: () {
                print('点击轮播图');
              },
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

// 首页分类导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item, index) {
    return InkWell(
      onTap: () {
        print("navigate item 点击分类了");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['firstCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }

    var tempIndex = -1;
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 5.0),
        height: ScreenUtil().setHeight(320),
        padding: EdgeInsets.all(3.0),
        child: GridView.count(
          // 禁止滚动
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          padding: EdgeInsets.all(4.0),
          children: navigatorList.map((item) {
            tempIndex++;
            return _gridViewItemUI(context, item, tempIndex);
          }).toList(),
        ));
  }
}

// 推荐商品
class RecommendUI extends StatelessWidget {
  final List recommendList;
  const RecommendUI({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(context),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: KColor.defaultBorderColor,
              width: 0.5,
            ),
          )),
      child: Text(
        KString.recommendText,
        style: TextStyle(color: KColor.homeSubTitleTextColor),
      ),
    );
  }

  // 商品推荐列表
  Widget _recommendList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index, context);
        },
      ),
    );
  }

  Widget _item(index, context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(200),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              left: BorderSide(width: 0.5, color: KColor.defaultBorderColor)),
        ),
        child: Column(
          children: <Widget>[
            // 防止溢出
            Expanded(
                child: Image.network(
              recommendList[index]['image'],
              fit: BoxFit.contain,
            )),
            Text(
              '￥${recommendList[index]['presentPrice']}',
              style: TextStyle(color: KColor.presentPriceColor),
            ),
            Text(
              '￥${recommendList[index]['oriPrice']}',
              style: KFont.oriPriceStyle,
            ),
          ],
        ),
      ),
    );
  }
}

// 推荐中间广告位
class FloorPic extends StatelessWidget {
  final Map floorPic;
  const FloorPic({Key key, this.floorPic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: InkWell(
        child: Image.network(
          floorPic['pic_address'],
          fit: BoxFit.cover,
          height: ScreenUtil().setHeight(100),
        ),
        onTap: () {
          print("click floor pic area");
        },
      ),
    );
  }
}
