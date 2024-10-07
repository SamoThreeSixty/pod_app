import 'package:pod_app/features/cached/data/datasource/cached_datasource.dart';
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';

class CachedRemoteDataSource implements CachedDataSource {
  @override
  Future<void> addCachedData(CachedData cachedData) {
    // TODO: implement addCachedData
    throw UnimplementedError();
  }

  @override
  Future<void> addCachedImage(CachedImage cachedImage) {
    // TODO: implement addCachedImage
    throw UnimplementedError();
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
  Future<List<CachedImage>> getAllCachedImages() {
    // TODO: implement getAllCachedImages
    throw UnimplementedError();
  }
}
