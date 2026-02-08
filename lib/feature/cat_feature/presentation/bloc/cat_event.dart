import 'package:equatable/equatable.dart';

abstract class CatEvent extends Equatable {}

class GetCatEvent extends CatEvent {
  @override
  List<Object?> get props => [];
}
