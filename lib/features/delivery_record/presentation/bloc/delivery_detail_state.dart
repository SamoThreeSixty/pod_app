part of 'delivery_detail_bloc.dart';

@immutable
sealed class DeliveryDetailState {}

final class DeliveryDetailInitial extends DeliveryDetailState {}

final class DeliveryDetailLoading extends DeliveryDetailState {}

final class DeliveryDetailSuccess extends DeliveryDetailState {
  final List<DeliveryDetail> deliveryDetail;

  DeliveryDetailSuccess(this.deliveryDetail);
}

final class DeliveryDetailFailure extends DeliveryDetailState {
  final String message;

  DeliveryDetailFailure(this.message);
}
