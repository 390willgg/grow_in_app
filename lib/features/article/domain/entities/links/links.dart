import 'package:equatable/equatable.dart';

class Links extends Equatable {
  final String self;
  final String plant;
  final String genus;
  final String? species;

  const Links({
    this.species,
    required this.genus,
    required this.plant,
    required this.self,
  });

  @override
  List<Object?> get props => [genus, plant, self];
}
