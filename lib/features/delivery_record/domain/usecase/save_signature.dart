import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/repository/delivery_detail_repository.dart';

class SaveSignature implements UseCase<void, SaveSignatureParams> {
  final DeliveryDetailRepository deliveryDetailRepository;
  SaveSignature(this.deliveryDetailRepository);

  @override
  Future<Either<Failure, void>> call(SaveSignatureParams params) async {
    try {
      await deliveryDetailRepository.saveSignature(
          params.path, params.deliveryID);
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

class SaveSignatureParams {
  final String path;
  final int deliveryID;

  SaveSignatureParams({required this.path, required this.deliveryID});
}
