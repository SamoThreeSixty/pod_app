import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_list/domain/repository/delivery_header_repository.dart';

class GetFilteredDeliveryHeaders
    implements UseCase<List<DeliveryHeader>, NoParams> {
  DeliveryHeaderRepository _deliveryHeaderRepository;

  GetFilteredDeliveryHeaders(this._deliveryHeaderRepository);

  @override
  Future<Either<Failure, List<DeliveryHeader>>> call(NoParams params) async {
    // TODO: define filters and implement
    return await _deliveryHeaderRepository.getFilteredDeliveries();
  }
}
