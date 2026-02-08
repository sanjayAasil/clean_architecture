import 'package:hive/hive.dart';

import '../models/product_model.dart';

abstract class LocalProductDatasource {
  Future<List<ProductModel>> getCachedProducts();

  Future<void> cacheProducts(List<ProductModel> products);
}

class LocalProductDatasourceImpl implements LocalProductDatasource {
  static String productBox = "product_box";

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final product = Hive.box(productBox);
    await product.put("products", productModelToJson(products));
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final cache = await Hive.box(productBox).get("products");

    if (cache != null) {
      return productModelFromJson(cache);
    }
    return [];
  }
}
