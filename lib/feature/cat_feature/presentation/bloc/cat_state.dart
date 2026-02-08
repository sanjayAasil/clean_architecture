import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final List<CatEntity> cats;

  CatLoaded(this.cats);

  @override
  List<Object?> get props => [cats];
}

class CatError extends CatState {
  final String error;

  CatError(this.error);

  @override
  List<Object?> get props => [error];
}
