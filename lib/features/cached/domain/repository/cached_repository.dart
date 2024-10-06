import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';

// Entities
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';

abstract interface class CachedRepository {
  Future<Either<Failure, void>> addCachedData(CachedData cachedData);

  Future<Either<Failure, void>> addCachedImage(CachedImage cachedImage);

  // Will just do all of it for now. Will return an int of how many synced
  Future<Either<Failure, int>> syncCachedData();

  // Will just do all of it for now. Will return an int of how many synced
  Future<Either<Failure, int>> syncCachedImages();
}
