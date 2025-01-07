import 'package:grow_in_app/features/article/domain/entities/pagination_links/pagination_links.dart';

class PaginationLinksModel extends PaginationLinks {
  const PaginationLinksModel({
    required super.first,
    required super.last,
    required super.next,
    required super.self,
  });

  factory PaginationLinksModel.fromJson(Map<String, dynamic> json) {
    return PaginationLinksModel(
      first: json['first'],
      last: json['last'],
      next: json['next'],
      self: json['self'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'next': next,
      'self': self,
    };
  }
}
