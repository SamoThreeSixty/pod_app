import 'dart:io';

import 'package:pod_app/core/service/supabase_storage.dart';
import 'package:pod_app/features/delivery_record/data/model/delivery_detail_model.dart';
import 'package:pod_app/features/delivery_record/data/datasource/delivery_detail_data_source.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeliveryDetailRemoteDateSource implements DeliveryDetailDataSource {
  final SupabaseClient _supabaseClient;

  DeliveryDetailRemoteDateSource(this._supabaseClient);

  @override
  Future<List<DeliveryDetail>> getDeliveryDetail(int id) async {
    try {
      final List<dynamic> response = await _supabaseClient
          .from('delivery_detail')
          .select()
          .eq('delivery_header_id', id);

      return response
          .map((deliveryDetail) => DeliveryDetailModel.fromJson(deliveryDetail))
          .toList();
    } catch (e) {
      throw Exception('Error loading from Supabase');
    }
  }

  @override
  Future<void> saveImages(List<String> paths, int deliveryID) async {
    for (int index = 0; index < paths.length; index++) {
      var image = paths[index];

      await SupabaseStorageService(_supabaseClient)
          .uploadPodImage(File(image), deliveryID, index + 1);
    }
  }

  @override
  Future<void> saveSignature(String path, int deliveryID) async {
    await SupabaseStorageService(_supabaseClient)
        .uploadPodSignature(File(path), deliveryID);
  }
}
