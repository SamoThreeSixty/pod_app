import 'dart:developer';

import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/delivery_record/data/datasource/delivery_detail_local_data_source.dart';
import 'package:pod_app/features/delivery_record/data/datasource/delivery_detail_remote_data_source.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/domain/repository/delivery_detail_repository.dart';

class DeliveryDetailRepositoryImpl implements DeliveryDetailRepository {
  final DeliveryDetailRemoteDateSource deliveryDetailRemoteDateSourceImp;
  final DeliveryDetailLocalDataSource deliveryDetailLocalDateSourceImp;

  DeliveryDetailRepositoryImpl(this.deliveryDetailRemoteDateSourceImp,
      this.deliveryDetailLocalDateSourceImp);

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

  @override
  Future<Either<Failure, void>> saveImages(
      List<String> paths, int deliveryID) async {
    try {
      // Local first
      await deliveryDetailLocalDateSourceImp.saveImages(paths, deliveryID);
      await deliveryDetailRemoteDateSourceImp.saveImages(paths, deliveryID);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveSignature(
      String path, int deliveryID) async {
    try {
      await deliveryDetailRemoteDateSourceImp.saveSignature(path, deliveryID);
      await deliveryDetailLocalDateSourceImp.saveSignature(path, deliveryID);
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
