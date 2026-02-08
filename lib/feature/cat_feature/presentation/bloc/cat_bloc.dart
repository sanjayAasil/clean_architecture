import 'package:bloc/bloc.dart';
import 'package:demo_2/feature/cat_feature/domain/usecase/get_cats.dart';
import 'package:demo_2/feature/cat_feature/presentation/bloc/cat_event.dart';
import 'package:demo_2/feature/cat_feature/presentation/bloc/cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final GetCats getCats;

  CatBloc(this.getCats) : super(CatInitial()) {
    on((event, emit) async {
      emit(CatLoading());
      try {
        final cats = await getCats();
        emit(CatLoaded(cats));
      } catch (e) {
        emit(CatError("Error Fetching Cats: $e"));
      }
    });
  }
}
