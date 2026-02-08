import 'package:bloc/bloc.dart';
import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';
import 'package:demo_2/feature/cat_feature/domain/usecase/get_cats.dart';
import 'package:demo_2/feature/cat_feature/presentation/bloc/cat_event.dart';
import 'package:demo_2/feature/cat_feature/presentation/bloc/cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final GetCats getCats;
  final List<CatEntity> catList = [];

  CatBloc(this.getCats) : super(CatInitial()) {
    on<GetCatEvent>((event, emit) async {
      emit(CatLoading());
      try {
        if (!event.isLoadMore) {
          emit(CatLoading());
          catList.clear();
        } else {
          emit(CatLoaded(cats: catList, isLoadingMore: false));
        }
        final cats = await getCats(limit: 20, page: event.page);
        catList.addAll(cats);
        print("final list ${catList.length}");
        emit(CatLoaded(cats: catList, isLoadingMore: false));
      } catch (e) {
        emit(CatError("Error Fetching Cats: $e"));
      }
    });
  }
}
