import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/delivery_list/data/datasources/delivery_datasource.dart';
import 'package:pod_app/features/delivery_list/data/datasources/delivery_remote_datasource.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_list/domain/repository/delivery_header_repository.dart';

class DeliveryListRepositoryImp implements DeliveryHeaderRepository {
  final DeliveryListRemoteDataSource deliveryRemoteDataSource;

  DeliveryListRepositoryImp(this.deliveryRemoteDataSource);

  @override
  Future<Either<Failure, void>> changeDeliveryStatus(int id, int status) {
    // TODO: implement changeDeliveryStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteDelivery(int id) {
    // TODO: implement deleteDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DeliveryHeader>>> getAllDeliveries() async {
    try {
      final deliveries = await deliveryRemoteDataSource.getAllDeliveries();
      return right(deliveries);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<DeliveryHeader>>> getFilteredDeliveries() {
    // TODO: implement getFilteredDeliveries
    throw UnimplementedError();
  }
}
