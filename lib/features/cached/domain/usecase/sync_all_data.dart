import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';
import 'package:pod_app/features/cached/domain/repository/cached_repository.dart';

class SyncAllImages implements UseCase<int, NoParams> {
  final CachedRepository _cachedRepository;

  SyncAllImages(this._cachedRepository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await _cachedRepository.syncCachedData();
  }
}
