import 'package:bloc/bloc.dart';
import 'package:demo_2/feature/product_feature/presentation/bloc/product_event.dart';
import 'package:demo_2/feature/product_feature/presentation/bloc/product_state.dart';
import '../../domain/usecase/get_products.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc(this.getProducts) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        final products = await getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError("Error fetching products: $e"));
      }
    });
  }
}
