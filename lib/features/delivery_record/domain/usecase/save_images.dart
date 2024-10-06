import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/repository/delivery_detail_repository.dart';

class SaveImages implements UseCase<void, SaveImagesParams> {
  final DeliveryDetailRepository deliveryDetailRepository;
  SaveImages(this.deliveryDetailRepository);

  @override
  Future<Either<Failure, void>> call(SaveImagesParams params) async {
    try {
      await deliveryDetailRepository.saveImages(
          params.paths, params.deliveryID);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}

class SaveImagesParams {
  final List<String> paths;
  final int deliveryID;

  SaveImagesParams({required this.paths, required this.deliveryID});
}
