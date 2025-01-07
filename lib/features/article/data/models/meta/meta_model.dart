import '../../../domain/entities/meta/meta.dart';

class MetaModel extends Meta {
  const MetaModel({
    required super.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
    };
  }
}
