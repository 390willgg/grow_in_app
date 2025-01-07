import 'package:equatable/equatable.dart';
import 'package:grow_in_app/features/article/domain/entities/pagination_links/pagination_links.dart';
import 'package:grow_in_app/features/article/domain/entities/spesies/species.dart';

import '../meta/meta.dart';

class Plants extends Equatable {
  final List<Species> data;
  final PaginationLinks links;
  final Meta meta;

  const Plants({required this.data, required this.links, required this.meta});

  @override
  List<Object?> get props => [data, links, meta];
}
