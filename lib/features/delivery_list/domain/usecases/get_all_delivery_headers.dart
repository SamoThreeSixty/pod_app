import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_list/domain/repository/delivery_header_repository.dart';

class GetAllDeliveryHeaders implements UseCase<List<DeliveryHeader>, NoParams> {
  DeliveryHeaderRepository _deliveryHeaderRepository;

  GetAllDeliveryHeaders(this._deliveryHeaderRepository);

  @override
  Future<Either<Failure, List<DeliveryHeader>>> call(NoParams params) async {
    return await _deliveryHeaderRepository.getAllDeliveries();
  }
}
