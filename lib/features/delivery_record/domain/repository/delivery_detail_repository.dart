import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';

abstract interface class DeliveryDetailRepository {
  Future<Either<Failure, List<DeliveryDetail>>> getDeliveryDetail(int id);
}
