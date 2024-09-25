part of 'delivery_list_bloc.dart';

@immutable
sealed class DeliveryListEvent {}

final class GetAllDeliveryList extends DeliveryListEvent {}
