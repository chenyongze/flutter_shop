import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:alipay_kit/alipay_kit.dart';

// 测试 支付宝支付
class AlipayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

/// pkcs1 -> '-----BEGIN RSA PRIVATE KEY-----\n${支付宝RSA签名工具生产的私钥}\n-----END RSA PRIVATE KEY-----'
/// pkcs8 -> '-----BEGIN PRIVATE KEY-----\n${支付宝RSA签名工具生产的私钥}\n-----END PRIVATE KEY-----'
class _HomeState extends State<Home> {
  static const bool _ALIPAY_USE_RSA2 = true;
  static const String _ALIPAY_APPID = 'your alipay appId'; // 支付/登录
  static const String _ALIPAY_PID = 'your alipay pid'; // 登录
  static const String _ALIPAY_TARGETID = 'your alipay targetId'; // 登录
  static const String _ALIPAY_PRIVATEKEY =
      'your alipay rsa private key(pkcs1/pkcs8)'; // 支付/登录

  Alipay _alipay = Alipay();

  StreamSubscription<AlipayResp> _pay;
  StreamSubscription<AlipayResp> _auth;

  @override
  void initState() {
    super.initState();
    _pay = _alipay.payResp().listen(_listenPay);
    _auth = _alipay.authResp().listen(_listenAuth);
  }

  void _listenPay(AlipayResp resp) {
    String content = 'pay: ${resp.resultStatus} - ${resp.result}';
    _showTips('支付', content);
  }

  void _listenAuth(AlipayResp resp) {
    String content = 'pay: ${resp.resultStatus} - ${resp.result}';
    _showTips('授权登录', content);
  }

  @override
  void dispose() {
    _pay?.cancel();
    _pay = null;
    _auth?.cancel();
    _auth = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alipay Kit Demo'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('1.环境检查'),
            onTap: () async {
              String content = 'alipay: ${await _alipay.isInstalled()}';
              _showTips('环境检查', content);
            },
          ),
          ListTile(
            title: const Text('2.支付'),
            onTap: () {
              Map<String, dynamic> bizContent = <String, dynamic>{
                'timeout_express': '30m',
                'product_code': 'QUICK_MSECURITY_PAY',
                'total_amount': '0.01',
                'subject': '1',
                'body': '我是测试数据',
                'out_trade_no': '123456789',
              };
              Map<String, dynamic> orderInfo = <String, dynamic>{
                'app_id': _ALIPAY_APPID,
                'biz_content': json.encode(bizContent),
                'charset': 'utf-8',
                'method': 'alipay.trade.app.pay',
                'timestamp': '2016-07-29 16:55:53',
                'version': '1.0',
              };
              _alipay.payOrderJson(
                orderInfo: json.encode(orderInfo),
                signType: _ALIPAY_USE_RSA2
                    ? Alipay.SIGNTYPE_RSA2
                    : Alipay.SIGNTYPE_RSA,
                privateKey: _ALIPAY_PRIVATEKEY,
              );
            },
          ),
          ListTile(
            title: const Text('3.授权'),
            onTap: () {
              _alipay.auth(
                appId: _ALIPAY_APPID,
                pid: _ALIPAY_PID,
                targetId: _ALIPAY_TARGETID,
                privateKey: _ALIPAY_PRIVATEKEY,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showTips(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }
}
