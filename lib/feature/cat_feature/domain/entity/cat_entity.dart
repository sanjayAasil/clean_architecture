import 'package:equatable/equatable.dart';

abstract class Cat extends Equatable {
  @override
  List<Object?> get props => [];
}

class CatEntity extends Cat {
  final String id;
  final String url;
  final String width;
  final String height;

  CatEntity({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [id, url, width, height];
}
