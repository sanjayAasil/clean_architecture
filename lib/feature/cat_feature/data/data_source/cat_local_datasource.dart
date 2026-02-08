import 'dart:convert';

import 'package:demo_2/feature/cat_feature/data/models/cat_model.dart';
import 'package:hive/hive.dart';

abstract class LocalCatDatasource {
  Future<List<CatModel>> getCachedCats();

  Future<void> cacheCats(List<CatModel> cats);
}

class LocalCatDatasourceImpl implements LocalCatDatasource {
  @override
  Future<List<CatModel>> getCachedCats() async {
    final hive = Hive.box("cats");
    final cache = await hive.get("cat_list");
    if (cache != null) {
      return catModelFromJson(jsonEncode(cache));
    }
    return [];
  }

  @override
  Future<void> cacheCats(List<CatModel> cats) async {
    final hive = Hive.box("cats");
    await hive.put("cat_list", catModelToJson(cats));
  }
}
