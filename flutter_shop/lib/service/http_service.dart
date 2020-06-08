import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

import '../config/index.dart';

Future request(url, {formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    // dio.options.contentType =
    //     ContentType.parse('application/x-www-form-urlencoded');
    dio.options.contentType = Headers.formUrlEncodedContentType;
    if (formData == null) {
      print(servicePath[url]);
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('error :::r');
  }
}
