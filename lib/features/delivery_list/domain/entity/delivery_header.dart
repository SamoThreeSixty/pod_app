class DeliveryHeader {
  final int id;
  final int status;
  final DateTime created_at;
  final String customer;
  final String address_line_1;
  final String address_line_2;
  final String city;
  final String region;
  final String postcode;
  final String country;
  final double lat;
  final double long;
  final int route_id;
  final int vehicle_id;

  DeliveryHeader({
    required this.id,
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
}
