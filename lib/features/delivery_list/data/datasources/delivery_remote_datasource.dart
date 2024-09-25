import 'package:pod_app/features/delivery_list/data/datasources/delivery_datasource.dart';
import 'package:pod_app/features/delivery_list/data/model/delivery_header_model.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeliveryListRemoteDataSource implements DeliveryListDataSource {
  SupabaseClient supabaseClient;

  DeliveryListRemoteDataSource(this.supabaseClient);
  @override
  Future<void> changeDeliveryStatus(int id, int status) {
    // TODO: implement changeDeliveryStatus
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDelivery(int id) {
    // TODO: implement deleteDelivery
    throw UnimplementedError();
  }

  @override
  Future<List<DeliveryHeader>> getAllDeliveries() async {
    try {
      final List<dynamic> response =
          await supabaseClient.from('delivery_header').select();

      return response
          .map((deliveryHeader) => DeliveryHeaderModel.fromJson(deliveryHeader))
          .toList();
    } catch (e) {
      throw Exception('Error loading from Supabase');
    }
  }

  @override
  Future<List<DeliveryHeader>> getFilteredDeliveries() {
    // TODO: implement getFilteredDeliveries
    throw UnimplementedError();
  }
}
