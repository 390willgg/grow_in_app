import 'dart:ui';

import 'package:equatable/equatable.dart';

class Flower extends Equatable {
  final List<Color> color;
  final bool conspicuous;

  const Flower({required this.color, required this.conspicuous});

  @override
  List<Object?> get props => throw UnimplementedError();
}
