import 'dart:convert';

import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';

List<CatModel> catModelFromJson(String str) =>
    List<CatModel>.from(json.decode(str).map((x) => CatModel.fromJson(x)));

String catModelToJson(List<CatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatModel {
  final String id;
  final String url;
  final String width;
  final String height;

  CatModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
    id: json["id"].toString(),
    url: json["url"].toString(),
    width: json["width"].toString(),
    height: json["height"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "width": width,
    "height": height,
  };

  CatEntity toEntity() =>
      CatEntity(id: id, url: url, width: width, height: height);
}
