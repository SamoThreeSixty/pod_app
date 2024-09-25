import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';

abstract interface class DeliveryListDataSource {
  Future<List<DeliveryHeader>> getAllDeliveries();

  Future<List<DeliveryHeader>> getFilteredDeliveries();

  Future<void> changeDeliveryStatus(int id, int status);

  Future<void> deleteDelivery(int id);
}
