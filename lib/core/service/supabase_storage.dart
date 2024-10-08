import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ISupabaseStorage {
  /// Retrieves an image from the specified bucket.
  ///
  /// [bucket] is the name of the storage bucket.
  /// [image] is the name of the image file.
  /// Returns a [Uint8List] of the image data, or `null` if an error occurs.
  Future<Uint8List?> getImage(String bucket, String image);

  /// Uploads an image to the images bucket.
  ///
  /// [image] is the name of the image file to upload.
  /// Returns the URL of the uploaded image as a [String].
  Future<String?> uploadPodImage(File image, int orderNo, int imageNumber);

  /// Uploads an image to the signature bucket.
  ///
  /// [image] is the name of the image file to upload.
  /// Returns the URL of the uploaded image as a [String].
  Future<String?> uploadPodSignature(File image, int orderNo);
}

class SupabaseStorageService implements ISupabaseStorage {
  final SupabaseClient _supabaseClient;

  SupabaseStorageService(this._supabaseClient);

  @override
  Future<Uint8List?> getImage(String bucket, String image) async {
    try {
      final response =
          await _supabaseClient.storage.from(bucket).download(image);
      return response;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  @override
  Future<String?> uploadPodImage(
      File image, int orderNo, int imageNumber) async {
    try {
      String baseName = 'order_${orderNo.toString()}_$imageNumber';

      final String fullPath = await _supabaseClient.storage
          .from('pod_images')
          .upload(
            baseName,
            image,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      return fullPath;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<String?> uploadPodSignature(File image, int orderNo) async {
    try {
      String baseName = 'order_${orderNo.toString()}';

      final String fullPath = await _supabaseClient.storage
          .from('pod_signature')
          .upload(
            baseName,
            image,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      return fullPath;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
