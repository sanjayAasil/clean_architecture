
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts({required this.repository});

  Future<List<ProductEntity>> call() {
    return repository.getProductEntities();
  }
}
