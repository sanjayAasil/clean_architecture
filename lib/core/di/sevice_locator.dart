import 'package:demo_2/feature/cat_feature/data/data_source/cat_local_datasource.dart';
import 'package:demo_2/feature/cat_feature/data/data_source/cat_remote_datasource.dart';
import 'package:demo_2/feature/cat_feature/data/repository/cat_repository_impl.dart';
import 'package:demo_2/feature/cat_feature/domain/repository/cat_repository.dart';
import 'package:demo_2/feature/cat_feature/domain/usecase/get_cats.dart';
import 'package:demo_2/feature/cat_feature/presentation/bloc/cat_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../feature/product_feature/data/data_source/local_product_datasource.dart';
import '../../feature/product_feature/data/data_source/remote_product_datasource.dart';
import '../../feature/product_feature/data/repositories/product_repository_impl.dart';
import '../../feature/product_feature/domain/repository/product_repository.dart';
import '../../feature/product_feature/domain/usecase/get_products.dart';
import '../../feature/product_feature/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> initDependencies() async {
    // ---------------- DATA ----------------
    sl.registerLazySingleton<RemoteProductDatasource>(
      () => RemoteProductDataSourceImpl(),
    );
    sl.registerLazySingleton<RemoteCatDatasource>(
      () => RemoteCatDatasourceImpl(),
    );

    sl.registerLazySingleton<LocalCatDatasource>(
      () => LocalCatDatasourceImpl(),
    );
    sl.registerLazySingleton<LocalProductDatasource>(
      () => LocalProductDatasourceImpl(),
    );

    sl.registerLazySingleton<CatRepository>(
      () => CatRepositoryImpl(remote: sl(), local: sl()),
    );
    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteProductDatasource: sl(),
        localProductDatasource: sl(),
      ),
    );

    // ---------------- DOMAIN ----------------
    sl.registerLazySingleton(() => GetProducts(repository: sl()));
    sl.registerLazySingleton(() => GetCats(sl()));

    // ---------------- PRESENTATION ----------------
    sl.registerFactory(() => ProductBloc(sl()));
    sl.registerFactory(() => CatBloc(sl()));
  }
}
