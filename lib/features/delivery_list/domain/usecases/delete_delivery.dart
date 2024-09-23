import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_list/domain/repository/delivery_header_repository.dart';

class DeleteDelivery implements UseCase<void, int> {
  DeliveryHeaderRepository _deliveryHeaderRepository;

  DeleteDelivery(this._deliveryHeaderRepository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await _deliveryHeaderRepository.deleteDelivery(id);
  }
}
