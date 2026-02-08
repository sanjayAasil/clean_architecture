
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/local_product_datasource.dart';
import '../data_source/remote_product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteProductDatasource remoteProductDatasource;
  final LocalProductDatasource localProductDatasource;

  ProductRepositoryImpl({
    required this.remoteProductDatasource,
    required this.localProductDatasource,
  });

  @override
  Future<List<ProductEntity>> getProductEntities() async {
    try {
      final products = await remoteProductDatasource.getAllProducts();
      localProductDatasource.cacheProducts(products);
      return products.map((e) => e.toEntity()).toList();
    } catch (e) {
      final cache = await localProductDatasource.getCachedProducts();
      return cache.map((e) => e.toEntity()).toList();
    }
  }
}
