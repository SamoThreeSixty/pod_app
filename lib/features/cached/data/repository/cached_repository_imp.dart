import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/cached/data/datasource/cached_local_datasource.dart';
import 'package:pod_app/features/cached/data/datasource/cached_remote_datasource.dart';
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';
import 'package:pod_app/features/cached/domain/repository/cached_repository.dart';

class CachedRepositoryImp implements CachedRepository {
  final CachedRemoteDataSource cachedRemoteDataSource;
  final CachedLocalDataSource cachedLocalDataSource;

  CachedRepositoryImp({
    required this.cachedRemoteDataSource,
    required this.cachedLocalDataSource,
  });

  @override
  Future<Either<Failure, void>> addCachedData(CachedData cachedData) async {
    try {
      await cachedLocalDataSource.addCachedData(cachedData);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addCachedImage(CachedImage cachedImage) async {
    try {
      await cachedLocalDataSource.addCachedImage(cachedImage);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> syncCachedData() {
    // TODO: implement syncCachedData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> syncCachedImages() {
    // TODO: implement syncCachedImages
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CachedImage>>> getAllCachedImages() async {
    try {
      final res = await cachedRemoteDataSource.getAllCachedImages();
      return right(res);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
