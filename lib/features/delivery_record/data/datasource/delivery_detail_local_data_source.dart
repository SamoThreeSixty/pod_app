import 'package:pod_app/core/service/file_service.dart';
import 'package:pod_app/features/delivery_record/data/datasource/delivery_detail_data_source.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';

class DeliveryDetailLocalDataSource implements DeliveryDetailDataSource {
  final FileService _fileService = FileService();

  @override
  Future<List<DeliveryDetail>> getDeliveryDetail(int id) {
    // TODO: implement getDeliveryDetail
    throw UnimplementedError();
  }

  @override
  Future<void> saveImages(List<String> paths, int deliveryID) async {
    for (int index = 0; index < paths.length; index++) {
      var image = paths[index];
      await _fileService.saveImageToGallery(image);
    }
  }

  @override
  Future<void> saveSignature(String path, int deliveryID) async {
    await _fileService.saveImageToGallery(path);
  }
}
