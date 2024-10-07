import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';
import 'package:pod_app/features/cached/domain/repository/cached_repository.dart';

class GetAllCachedImages implements UseCase<List<CachedImage>, NoParams> {
  final CachedRepository _cachedRepository;

  GetAllCachedImages(this._cachedRepository);

  @override
  Future<Either<Failure, List<CachedImage>>> call(NoParams params) async {
    return await _cachedRepository.getAllCachedImages();
  }
}
