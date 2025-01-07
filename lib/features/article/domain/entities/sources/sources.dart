import 'package:equatable/equatable.dart';

class Sources extends Equatable {
  final String id;
  final String name;
  final String citation;
  final String url;
  final String lastUpdated;

  const Sources({
    required this.id,
    required this.name,
    required this.citation,
    required this.url,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, name, citation, url, lastUpdated];
}
