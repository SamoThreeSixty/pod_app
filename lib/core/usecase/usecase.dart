import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
