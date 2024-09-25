import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';

class DeliveryHeaderModel extends DeliveryHeader {
  DeliveryHeaderModel({
    required super.id,
    required super.status,
    required super.created_at,
    required super.customer,
    required super.address_line_1,
    required super.address_line_2,
    required super.city,
    required super.region,
    required super.postcode,
    required super.country,
    required super.lat,
    required super.long,
    required super.route_id,
    required super.vehicle_id,
  });

  factory DeliveryHeaderModel.fromJson(Map<String, dynamic> json) {
    return DeliveryHeaderModel(
      id: json['id'] as int ?? 0,
      status: json['status'] as int ?? 0,
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      customer: json['customer'] as String ?? '',
      address_line_1: json['address_line_1'] as String ?? '',
      address_line_2: json['address_line_2'] as String ?? '',
      city: json['city'] as String ?? '',
      region: json['region'] as String ?? '',
      postcode: json['postcode'] as String ?? '',
      country: json['country'] as String ?? '',
      lat: json['lat'] as double ?? 0.0,
      long: json['long'] as double ?? 0.0,
      route_id: json['route_id'] as int? ?? 0,
      vehicle_id: json['vehicle_id'] as int? ?? 0,
    );
  }

  static List<DeliveryHeaderModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DeliveryHeaderModel.fromJson(json)).toList();
  }
}
