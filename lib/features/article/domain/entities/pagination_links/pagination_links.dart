import 'package:equatable/equatable.dart';

class PaginationLinks extends Equatable {
  final String first;
  final String last;
  final String next;
  final String self;

  const PaginationLinks({
    required this.first,
    required this.last,
    required this.next,
    required this.self,
  });

  @override
  List<Object?> get props => [first, last, next, self];
}
