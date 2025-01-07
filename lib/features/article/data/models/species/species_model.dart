import 'package:grow_in_app/features/article/domain/entities/spesies/species.dart';

class SpeciesModel extends Species {
  const SpeciesModel({
    required super.id,
    super.commonName,
    required super.slug,
    required super.scientificName,
    required super.author,
    required super.bibliography,
    required super.family,
    required super.familyCommonName,
    required super.genus,
    required super.genusId,
    required super.links,
    required super.plantId,
    required super.rank,
    required super.status,
    required super.synonyms,
    required super.year,
  });

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(
      author: json['author'],
      bibliography: json['bibliography'],
      commonName: json['common_name'],
      family: json['family'],
      familyCommonName: json['family_common_name'],
      genus: json['genus'],
      genusId: json['genus_id'],
      id: json['id'],
      links: json['links'],
      plantId: json['plant_id'],
      rank: json['rank'],
      scientificName: json['scientific_name'],
      slug: json['slug'],
      status: json['status'],
      synonyms: json['synonym'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'bibliography': bibliography,
      'common_name': commonName,
      'family': family,
      'family_common_name': familyCommonName,
      'genus': genus,
      'genus_id': genusId,
      'id': id,
      'links': links,
      'plant_id': plantId,
      'rank': rank,
      'scientific_name': scientificName,
      'slug': slug,
      'status': status,
      'synonym': synonyms,
      'year': year,
    };
  }
}
