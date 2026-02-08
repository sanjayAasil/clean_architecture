import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';
import 'package:demo_2/feature/cat_feature/domain/repository/cat_repository.dart';

class GetCats {
  final CatRepository repo;

  GetCats(this.repo);

  Future<List<CatEntity>> call({int page = 0, int limit = 20}) {
    return repo.getCatEntities(limit: limit, page: page);
  }
}
