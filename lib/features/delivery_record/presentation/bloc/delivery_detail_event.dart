part of 'delivery_detail_bloc.dart';

@immutable
sealed class DeliveryDetailEvent {}

class DeliveryGetDetails implements DeliveryDetailEvent {
  final int id;

  DeliveryGetDetails(this.id);
}

class SaveSignatureAndImages implements DeliveryDetailEvent {
  final List<String> imagePaths;
  final String signaturePath;
  final int deliveryId;

  SaveSignatureAndImages({
    required this.imagePaths,
    required this.signaturePath,
    required this.deliveryId,
  });
}
