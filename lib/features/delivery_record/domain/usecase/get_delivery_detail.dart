import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/repository/delivery_detail_repository.dart';

class GetDeliveryDetail implements UseCase<List<DeliveryDetail>, int> {
  final DeliveryDetailRepository deliveryDetailRepository;
  GetDeliveryDetail(this.deliveryDetailRepository);

  @override
  Future<Either<Failure, List<DeliveryDetail>>> call(int params) {
    return deliveryDetailRepository.getDeliveryDetail(params);
  }
}
