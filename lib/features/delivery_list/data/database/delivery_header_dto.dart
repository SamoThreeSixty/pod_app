import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';

const String tableEventLog = 'delivery_header';

class DeliveryHeaderFields {
  static final List<String> values = [
    id,
    status,
    created_at,
    customer,
    address_line_1,
    address_line_2,
    city,
    region,
    postcode,
    country,
    lat,
    long,
    route_id,
    vehicle_id,
  ];

  static const String id = 'id'; // This indicates it as the primary key
  static const String status = 'status';
  static const String created_at = 'created_at';
  static const String customer = 'customer';
  static const String address_line_1 = 'address_line_1';
  static const String address_line_2 = 'address_line_2';
  static const String city = 'city';
  static const String region = 'region';
  static const String postcode = 'postcode';
  static const String country = 'country';
  static const String lat = 'lat';
  static const String long = 'long';
  static const String route_id = 'route_id';
  static const String vehicle_id = 'vehicle_id';
}

class EventLogDto {
  final int? id;
  final int status;
  final DateTime created_at;
  final String customer;
  final String address_line_1;
  final String address_line_2;
  final String city;
  final String region;
  final String postcode;
  final String country;
  final int lat;
  final int long;
  final int route_id;
  final int vehicle_id;

  //TODO: what is this const method doing. Is it basically a constructor?
  const EventLogDto({
    this.id,
    required this.status,
    required this.created_at,
    required this.customer,
    required this.address_line_1,
    required this.address_line_2,
    required this.city,
    required this.region,
    required this.postcode,
    required this.country,
    required this.lat,
    required this.long,
    required this.route_id,
    required this.vehicle_id,
  });

  // TODO: what does this do, does it create a deep copy?
  EventLogDto copy({
    int? id,
    int? status,
    DateTime? created_at,
    String? customer,
    String? address_line_1,
    String? address_line_2,
    String? city,
    String? region,
    String? postcode,
    String? country,
    int? lat,
    int? long,
    int? route_id,
    int? vehicle_id,
  }) =>
      EventLogDto(
        id: id ?? this.id,
        status: status ?? this.status,
        created_at: created_at ?? this.created_at,
        customer: customer ?? this.customer,
        address_line_1: address_line_1 ?? this.address_line_1,
        address_line_2: address_line_2 ?? this.address_line_2,
        city: city ?? this.city,
        region: region ?? this.region,
        postcode: postcode ?? this.postcode,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        route_id: route_id ?? this.route_id,
        vehicle_id: vehicle_id ?? this.vehicle_id,
      );

  // Convert to the entity object when returning
  static DeliveryHeader fromJson(Map<String, Object?> json) => DeliveryHeader(
        id: json['_id'] as int,
        status: json['status'] as int,
        created_at: DateTime.parse(json['created_at'] as String),
        customer: json['customer'] as String,
        address_line_1: json['address_line_1'] as String,
        address_line_2: json['address_line_2'] as String,
        city: json['city'] as String,
        region: json['region'] as String,
        postcode: json['postcode'] as String,
        country: json['country'] as String,
        lat: json['lat'] as int,
        long: json['long'] as int,
        route_id: json['route_id'] as int,
        vehicle_id: json['vehicle_id'] as int,
      );

  Map<String, Object?> toJson() => {
        DeliveryHeaderFields.id: id,
        DeliveryHeaderFields.status: status,
        DeliveryHeaderFields.created_at: created_at,
        DeliveryHeaderFields.customer: customer,
        DeliveryHeaderFields.address_line_1: address_line_1,
        DeliveryHeaderFields.address_line_2: address_line_2,
        DeliveryHeaderFields.city: city,
        DeliveryHeaderFields.region: region,
        DeliveryHeaderFields.postcode: postcode,
        DeliveryHeaderFields.country: country,
        DeliveryHeaderFields.lat: lat,
        DeliveryHeaderFields.long: long,
        DeliveryHeaderFields.route_id: route_id,
        DeliveryHeaderFields.vehicle_id: vehicle_id,
      };
}
