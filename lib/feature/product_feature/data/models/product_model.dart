import 'dart:convert';
import '../../domain/entity/product_entity.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
  json.decode(str).map((x) => ProductModel.fromJson(x)),
);

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final Category category;
  final List<String> images;
  final DateTime creationAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    price: json["price"],
    description: json["description"],
    category: Category.fromJson(json["category"]),
    images: List<String>.from(json["images"].map((x) => x)),
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "price": price,
    "description": description,
    "category": category.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
    "creationAt": creationAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      price: price,
      description: description,
      category: category.toEntity(),
      images: images,
      creationAt: creationAt,
      updatedAt: updatedAt,
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String image;
  final DateTime creationAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    image: image ?? this.image,
    creationAt: creationAt ?? this.creationAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "creationAt": creationAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      creationAt: creationAt,
      updatedAt: updatedAt,
    );
  }
}
