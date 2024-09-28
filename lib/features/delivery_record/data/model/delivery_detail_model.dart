import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';

class DeliveryDetailModel extends DeliveryDetail {
  DeliveryDetailModel({
    required super.id,
    required super.delivery_header_id,
    required super.created_at,
    required super.status,
    required super.stock_ref,
    required super.quantity,
    required super.unit,
    required super.loaded,
    required super.loaded_date,
    required super.delivered,
    required super.delivered_date,
  });

  factory DeliveryDetailModel.fromJson(Map<String, dynamic> json) {
    return DeliveryDetailModel(
      id: json['id'] as int? ?? 0,
      delivery_header_id: json['delivery_header_id'] as int? ?? 0,
      created_at: DateTime.parse(json['created_at']),
      status: json['status'] as int? ?? 0,
      stock_ref: json['stock_ref'] as String? ?? "",
      quantity: json['quantity'] as int? ?? 0,
      unit: json['unit'] as String? ?? "",
      loaded: json['loaded'] as bool? ?? false,
      loaded_date: DateTime.parse(json['loaded_date']),
      delivered: json['delivered'] as bool? ?? false,
      delivered_date: DateTime.parse(json['delivered_date']),
    );
  }
}
