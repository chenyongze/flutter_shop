import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
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
  @override
  bool get wantKeepAlive => true;

  //火爆专区分页
  int page = 1;
  // 火爆专区列表数据
  List<Map> hotGoodsList = [];
  // 防止刷新，保持当前状态

  @override
  void initState() {
    super.initState();
    print("首页刷新...");
  }

  // GlobalKey<RefreshFooterState> _footerKey =
  //     new GlobalKey<RefreshFooterState>();

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

              print(swiperDataList);
              return EasyRefresh(
                footer: MaterialFooter(),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList),
                    TopNavigator(navigatorList: navigatorList),
                    RecommendUI(recommendList: recommendList),
                    FloorPic(floorPic: fp1),
                    Floor(floor: floor1),
                    _hotGoods(),
                  ],
                ),
                onLoad: () async {
                  print("开始加载更多");
                  _getHotGoods();
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

  void _getHotGoods() {
    var formPage = {'page': page};
    request('getHotGoods', formData: formPage).then((value) {
      var data = json.decode(value.toString());
      print(data);
      List<Map> newGoodsList = (data['data'] as List).cast();
      // 设置火爆专区数据列表
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  // 火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5, color: KColor.defaultBorderColor),
      ),
    ),
    child: Text(KString.hotGoodsTitle,
        style: TextStyle(color: KColor.homeSubTitleTextColor)),
  );

  // 火爆专区子项目
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  fit: BoxFit.cover,
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '￥${val['presentPrice']}',
                      style: TextStyle(
                        color: KColor.presentPriceColor,
                      ),
                    ),
                    Text(
                      '￥${val['oriPrice']}',
                      style: KFont.oriPriceStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  // 火爆专区组合
  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
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
            height: ScreenUtil().setHeight(65),
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

// 商品推荐下层
class Floor extends StatelessWidget {
  final List<Map> floor;
  const Floor({Key key, this.floor}) : super(key: key);

  void jumpDetail(context, int goodsId) {
    // 跳转商品详情
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.screenWidth;
    return Container(
      child: Row(
        children: <Widget>[
          // 左侧商品
          Expanded(
            child: Column(
              children: <Widget>[
                // 左上角大图
                Container(
                  padding: EdgeInsets.only(
                    top: 4,
                  ),
                  height: ScreenUtil().setHeight(400),
                  child: InkWell(
                    child: Image.network(
                      floor[0]['image'],
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      jumpDetail(context, floor[0]['goodsId']);
                    },
                  ),
                ),
                // 左下角小图
                Container(
                  padding: EdgeInsets.only(top: 1, right: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[1]['image'],
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      jumpDetail(context, floor[1]['goodsId']);
                    },
                  ),
                ),
              ],
            ),
          ),
          // 右侧商品
          Expanded(
            child: Column(
              children: <Widget>[
                // 右上图
                Container(
                  padding: EdgeInsets.only(top: 4, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[2]['image'],
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      jumpDetail(context, floor[2]['goodsId']);
                    },
                  ),
                ),
                // 右中图
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[3]['image'],
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      jumpDetail(context, floor[3]['goodsId']);
                    },
                  ),
                ),
                // 右下图
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[4]['image'],
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      jumpDetail(context, floor[4]['goodsId']);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
