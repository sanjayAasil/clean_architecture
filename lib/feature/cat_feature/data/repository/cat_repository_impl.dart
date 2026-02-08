import 'package:demo_2/feature/cat_feature/data/data_source/cat_local_datasource.dart';
import 'package:demo_2/feature/cat_feature/data/data_source/cat_remote_datasource.dart';
import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';
import 'package:demo_2/feature/cat_feature/domain/repository/cat_repository.dart';

class CatRepositoryImpl implements CatRepository {
  final LocalCatDatasource local;
  final RemoteCatDatasource remote;

  CatRepositoryImpl({required this.local, required this.remote});

  @override
  Future<List<CatEntity>> getCatEntities() async {
    // try {
      final cats = await remote.getCats();
      print('test ${cats.length}');
      local.cacheCats(cats);
      return cats.map((e) => e.toEntity()).toList();
    // } catch (e) {
    //   print('tessst check error $e');
    //   final cache = await local.getCachedCats();
    //   return cache.map((e) => e.toEntity()).toList();
    // }
  }
}
