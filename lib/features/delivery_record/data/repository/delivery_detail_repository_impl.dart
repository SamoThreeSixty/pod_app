import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/delivery_record/data/datasource/delivery_detail_remote_data_source.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/repository/delivery_detail_repository.dart';

class DeliveryDetailRepositoryImpl implements DeliveryDetailRepository {
  final DeliveryDetailRemoteDateSource deliveryDetailRemoteDateSourceImp;

  DeliveryDetailRepositoryImpl(this.deliveryDetailRemoteDateSourceImp);

  @override
  Future<Either<Failure, List<DeliveryDetail>>> getDeliveryDetail(
      int id) async {
    try {
      final deliveryDetail =
          await deliveryDetailRemoteDateSourceImp.getDeliveryDetail(id);
      return right(deliveryDetail);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
