import '../../../domain/entities/links/links.dart';

class LinksModel extends Links {
  const LinksModel({
    super.species,
    required super.genus,
    required super.plant,
    required super.self,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      species: json['species'],
      genus: json['genus'],
      plant: json['plant'],
      self: json['self'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'genus': genus, 'plant': plant, 'self': self};
  }
}
