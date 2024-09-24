import 'package:pod_app/features/delivery_list/data/datasources/delivery_data_datasource.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';

class DeliveryDataRemoteDatasource implements DeliveryDataDataSource {
  @override
  Future<void> changeDeliveryStatus(int id, int status) {
    // TODO: implement changeDeliveryStatus
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDelivery(int id) {
    // TODO: implement deleteDelivery
    throw UnimplementedError();
  }

  @override
  Future<List<DeliveryHeader>> getAllDeliveries() {
    // TODO: implement getAllDeliveries
    throw UnimplementedError();
  }

  @override
  Future<List<DeliveryHeader>> getFilteredDeliveries() {
    // TODO: implement getFilteredDeliveries
    throw UnimplementedError();
  }
}
