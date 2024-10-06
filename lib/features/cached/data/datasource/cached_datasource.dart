import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';

abstract interface class CachedDataSource {
  Future<void> addCachedData(CachedData cachedData);

  Future<void> addCachedImage(CachedImage cachedImage);

  Future<int> syncCachedData();

  Future<int> syncCachedImages();
}
