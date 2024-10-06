import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:pod_app/features/cached/domain/repository/cached_repository.dart';

class AddCachedData implements UseCase<void, CachedData> {
  final CachedRepository _cachedRepository;

  AddCachedData(this._cachedRepository);

  @override
  Future<Either<Failure, void>> call(CachedData cachedData) async {
    try {
      await _cachedRepository.addCachedData(cachedData);
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
