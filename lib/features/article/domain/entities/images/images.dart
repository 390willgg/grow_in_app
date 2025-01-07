import 'package:equatable/equatable.dart';
import 'package:grow_in_app/features/article/domain/entities/flower/flower.dart';

class Images extends Equatable {
  final List<Flower> flower;

  const Images({required this.flower});

  @override
  List<Object?> get props => throw UnimplementedError();
}
