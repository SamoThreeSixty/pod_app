part of 'delivery_list_bloc.dart';

@immutable
sealed class DeliveryListState {}

final class DeliveryListInitial extends DeliveryListState {}

final class DeliveryListLoading extends DeliveryListState {}

final class DeliveryListSuccess extends DeliveryListState {
  final List<DeliveryHeader> deliveryHeader;

  DeliveryListSuccess(this.deliveryHeader);
}

final class DeliveryListFailure extends DeliveryListState {
  final String message;

  DeliveryListFailure(this.message);
}
