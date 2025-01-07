import 'package:equatable/equatable.dart';
import 'package:grow_in_app/features/article/domain/entities/links/links.dart';
import 'package:grow_in_app/features/article/domain/entities/sources/sources.dart';
import 'package:grow_in_app/features/article/domain/entities/synonyms/synonyms.dart';

class Species extends Equatable {
  final int id;
  final String? commonName;
  final String slug;
  final String? scientificName;
  final int? mainSpeciesId;
  final int? year;
  final String? bibliography;
  final String? author;
  final String? familyCommonName;
  final int genusId;
  final String? observations;
  final bool? vegetable;
  final Links links;
  final String? status;
  final String? rank;
  final String genus;
  final String family;
  final String? imageUrl;
  final List<String>? duration;
  final bool? edible;
  final Map<String, dynamic>? commonNames;
  final Map<String, dynamic>? distribution;
  final List<Synonyms>? synonyms;
  final List<Sources>? sources;
  final List<String>? ediblePart;
  final int plantId;

  const Species({
    required this.id,
    this.commonName,
    required this.slug,
    required this.scientificName,
    this.mainSpeciesId,
    this.year,
    this.bibliography,
    this.author,
    required this.status,
    required this.rank,
    this.familyCommonName,
    required this.genusId,
    required this.genus,
    required this.family,
    this.imageUrl,
    this.duration,
    this.edible,
    this.vegetable,
    this.observations,
    this.commonNames,
    this.distribution,
    this.synonyms,
    this.sources,
    this.ediblePart,
    required this.links,
    required this.plantId,
  });

  @override
  List<Object?> get props => [
        id,
        commonName,
        slug,
        scientificName,
        year,
        bibliography,
        author,
        status,
        rank,
        familyCommonName,
        genusId,
        genus,
        family,
        imageUrl,
        duration,
        edible,
        vegetable,
        observations,
        commonNames,
        distribution,
        synonyms,
        sources,
        ediblePart,
        links,
        plantId
      ];
}
