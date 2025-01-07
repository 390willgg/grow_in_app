import 'package:equatable/equatable.dart';

class Synonyms extends Equatable {
  final String id;
  final String name;
  final String author;

  const Synonyms({required this.id, required this.name, required this.author});

  @override
  List<Object?> get props => [id, name, author];
}
