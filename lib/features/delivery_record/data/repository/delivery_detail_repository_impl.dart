import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/common/cubits/connectivity/connectivity_cubit.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/cached/data/database/cached_image_database.dart';
import 'package:pod_app/features/cached/data/database/cached_image_dto.dart';
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
      final connectivityStatus = ConnectivityCubit().state;
      List<DeliveryDetail> deliveryDetail = [];

      if (connectivityStatus == ConnectivityResult.none) {
        //@TODO get a local db set up
      } else {
        deliveryDetail =
            await deliveryDetailRemoteDateSourceImp.getDeliveryDetail(id);
      }

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
      final connectivityStatus = ConnectivityCubit().state;

      if (connectivityStatus == ConnectivityResult.none) {
        await deliveryDetailLocalDateSourceImp.saveImages(paths, deliveryID);
      } else {
        await deliveryDetailLocalDateSourceImp.saveImages(paths, deliveryID);
        await deliveryDetailRemoteDateSourceImp.saveImages(paths, deliveryID);
      }

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
      final connectivityStatus = ConnectivityCubit().state;

      if (connectivityStatus == ConnectivityResult.none) {
        // Just save to local
        await deliveryDetailLocalDateSourceImp.saveSignature(path, deliveryID);

        // Save the cache record
        final cachedImageDto = CachedImageDto(
          name: 'order_$deliveryID',
          localPath: path,
          createdAt: DateTime.now(),
          syncAction: 'create',
          isSynced: false,
          syncedAt: null,
        );

        CachedImageDatabase.instance.insertCachedImage(cachedImageDto);
      } else {
        // Save to external and local
        await deliveryDetailLocalDateSourceImp.saveSignature(path, deliveryID);
        await deliveryDetailRemoteDateSourceImp.saveSignature(path, deliveryID);
      }

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
