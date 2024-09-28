part of 'delivery_detail_bloc.dart';

@immutable
sealed class DeliveryDetailEvent {}

class DeliveryGetDetails implements DeliveryDetailEvent {
  final int id;

  DeliveryGetDetails(this.id);
}
