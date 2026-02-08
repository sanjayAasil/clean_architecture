import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';

abstract class CatRepository {
  Future<List<CatEntity>> getCatEntities();
}
