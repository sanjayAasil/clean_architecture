import 'dart:convert';
import 'package:demo_2/core/network/dio_client.dart';
import 'package:demo_2/feature/cat_feature/data/models/cat_model.dart';
import 'package:dio/dio.dart';

abstract class RemoteCatDatasource {
  Future<List<CatModel>> getCats({int page = 0, int limit = 20});
}

class RemoteCatDatasourceImpl implements RemoteCatDatasource {
  @override
  Future<List<CatModel>> getCats({int limit = 20, int page = 0}) async {
    print('test callgerngerngenrgjnerg ');
    final Response response = await DioClient.catDio.get(
      '/search?limit=$limit&page=$page',
    );
    print("RES:: ${response.realUri}");
    print("RES:: ${response.statusCode}");
    print("RES:: ${response.data}");
    return catModelFromJson(jsonEncode(response.data));
  }
}
