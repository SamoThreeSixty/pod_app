import 'package:pod_app/features/cached/domain/entity/cached_images.dart';

class CachedImageModel extends CachedImage {
  CachedImageModel({
    required super.id,
    required super.name,
    required super.localPath,
    required super.galleryPath,
    required super.createdAt,
    required super.isSynced,
    required super.syncedAt,
    required super.syncAction,
  });

  factory CachedImageModel.fromJson(Map<String, dynamic> json) {
    return CachedImageModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      localPath: json['localPath'] as String? ?? '',
      galleryPath: json['galleryPath'] as String? ?? '',
      createdAt: json['createdAt'] as DateTime? ?? DateTime.now(),
      isSynced: json['isSynced'] as bool? ?? false,
      syncedAt: json['syncedAt'] as DateTime?,
      syncAction: json['syncAction'] as String? ?? '',
    );
  }
}
