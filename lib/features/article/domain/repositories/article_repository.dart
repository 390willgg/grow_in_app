import 'package:dartz/dartz.dart';
import 'package:grow_in_app/error/failure.dart';
import 'package:grow_in_app/features/article/domain/entities/plants/plants.dart';

abstract class ArticleRepository {
  Future<Either<Failure, Plants>> getListPlants(int page);

  Future<Either<Failure, Plants>> getPlant(int id);

  Future<Either<Failure, Plants>> getPlantsByFilter(String commonName);

  Future<Either<Failure, Plants>> getPlantsByRange(
    double? minHeight,
    double? maxHeight,
  );

  Future<Either<Failure, Plants>> getPlantsBySorting(
    Map<String, String>? sortBy,
    Map<String, String>? filters,
  );

  Future<Either<Failure, Plants>> getPlantsBySearch(String q);
}
