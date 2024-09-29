class DeliveryDetail {
  final int id;
  final int delivery_header_id;
  final DateTime created_at;
  final int status;
  final String stock_ref;
  final int quantity;
  final String unit;
  bool loaded;
  final DateTime? loaded_date;
  final bool delivered;
  final DateTime? delivered_date;

  DeliveryDetail({
    required this.id,
    required this.delivery_header_id,
    required this.created_at,
    required this.status,
    required this.stock_ref,
    required this.quantity,
    required this.unit,
    required this.loaded,
    required this.loaded_date,
    required this.delivered,
    required this.delivered_date,
  });
}
