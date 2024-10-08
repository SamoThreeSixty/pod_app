import 'package:pod_app/features/cached/data/database/cached_data_database.dart';
import 'package:pod_app/features/cached/data/database/cached_data_dto.dart';
import 'package:pod_app/features/cached/data/database/cached_image_database.dart';
import 'package:pod_app/features/cached/data/database/cached_image_dto.dart';
import 'package:pod_app/features/cached/data/datasource/cached_datasource.dart';
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';

class CachedLocalDataSource implements CachedDataSource {
  @override
  Future<void> addCachedData(CachedData cachedData) async {
    try {
      var db = CachedDataDatabase();

      await db.insertCachedImage(
        CachedDataDto.fromEntity(cachedData),
      );
    } catch (e) {
      throw Exception("Failed to add cached data: $e");
    }
  }

  @override
  Future<void> addCachedImage(CachedImage cachedImage) async {
    try {
      var db = CachedImageDatabase();

      await db.insertCachedImage(
        CachedImageDto.fromEntity(cachedImage),
      );
    } catch (e) {
      throw Exception("Failed to add cached image: $e");
    }
  }

  @override
  Future<int> syncCachedData() {
    // TODO: implement syncCachedData
    throw UnimplementedError();
  }

  @override
  Future<int> syncCachedImages() {
    // TODO: implement syncCachedImages
    throw UnimplementedError();
  }

  @override
  Future<List<CachedImage>> getAllCachedImages() async {
    try {
      var db = CachedImageDatabase();

      final List<CachedImage> cachedImages = await db.fetchAllCachedImages();

      return cachedImages;
    } catch (e) {
      throw Exception("Failed to get all cached images: $e");
    }
  }
}
