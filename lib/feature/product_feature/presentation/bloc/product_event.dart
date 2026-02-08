import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {}

class GetProductsEvent implements ProductEvent {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}
