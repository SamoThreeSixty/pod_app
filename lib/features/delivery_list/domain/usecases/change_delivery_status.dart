import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_list/domain/repository/delivery_header_repository.dart';

class ChangeDeliveryStatus
    implements UseCase<void, ChangeDeliveryStatusParams> {
  DeliveryHeaderRepository _deliveryHeaderRepository;

  ChangeDeliveryStatus(this._deliveryHeaderRepository);

  @override
  Future<Either<Failure, void>> call(ChangeDeliveryStatusParams params) async {
    return await _deliveryHeaderRepository.changeDeliveryStatus(
        params.id, params.status);
  }
}

class ChangeDeliveryStatusParams {
  final int id;
  final int status;

  ChangeDeliveryStatusParams({
    required this.id,
    required this.status,
  });
}
