import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';

abstract interface class DeliveryDetailDataSource {
  Future<List<DeliveryDetail>> getDeliveryDetail(int id);

  Future<void> saveSignature(String path, int deliveryID);
  Future<void> saveImages(List<String> paths, int deliveryID);
}
