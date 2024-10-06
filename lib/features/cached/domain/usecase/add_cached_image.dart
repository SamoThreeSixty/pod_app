import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';
import 'package:pod_app/features/cached/domain/repository/cached_repository.dart';

class AddCachedImage implements UseCase<void, CachedImage> {
  final CachedRepository _cachedRepository;

  AddCachedImage(this._cachedRepository);

  @override
  Future<Either<Failure, void>> call(CachedImage cachedImage) async {
    try {
      await _cachedRepository.addCachedImage(cachedImage);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
