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
      () => RemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<LocalProductDatasource>(
      () => LocalProductDatasourceImpl(),
    );

    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteProductDatasource: sl(),
        localProductDatasource: sl(),
      ),
    );

    // ---------------- DOMAIN ----------------
    sl.registerLazySingleton(() => GetProducts(repository: sl()));

    // ---------------- PRESENTATION ----------------
    sl.registerFactory(() => ProductBloc(sl()));
  }
}
