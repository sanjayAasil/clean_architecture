import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';
import 'package:demo_2/feature/cat_feature/domain/repository/cat_repository.dart';

class GetCats {
  final CatRepository repo;

  GetCats(this.repo);

  Future<List<CatEntity>> call() {
    return repo.getCatEntities();
  }
}
