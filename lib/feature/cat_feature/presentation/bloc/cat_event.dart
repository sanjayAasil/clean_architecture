import 'package:equatable/equatable.dart';

abstract class CatEvent extends Equatable {}

class GetCatEvent extends CatEvent {
  final bool isLoadMore;
  final int page;

  GetCatEvent({this.isLoadMore = false, required this.page});

  @override
  List<Object?> get props => [isLoadMore, page];
}
