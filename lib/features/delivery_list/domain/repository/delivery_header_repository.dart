import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';

abstract interface class DeliveryHeaderRepository {
  Future<Either<Failure, List<DeliveryHeader>>> getAllDeliveries();

  Future<Either<Failure, List<DeliveryHeader>>> getFilteredDeliveries();

  Future<Either<Failure, void>> changeDeliveryStatus(int id, int status);

  Future<Either<Failure, void>> deleteDelivery(int id);
}
