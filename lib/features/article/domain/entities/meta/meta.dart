import 'package:equatable/equatable.dart';

class Meta extends Equatable {
  final int total;

  const Meta({required this.total});

  @override
  List<Object?> get props => [total];
}
