import 'package:pod_app/features/cached/domain/entity/cached_image.dart';

class CachedImageModel extends CachedImage {
  CachedImageModel({
    required super.id,
    required super.name,
    required super.localPath,
    required super.createdAt,
    required super.isSynced,
    required super.syncedAt,
    required super.syncAction,
  });

  factory CachedImageModel.fromJson(Map<String, dynamic> json) {
    return CachedImageModel(
      id: json['id'],
      name: json['name'],
      localPath: json['localPath'],
      createdAt: json['createdAt'],
      isSynced: json['isSynced'],
      syncedAt: json['syncedAt'],
      syncAction: json['syncAction'],
    );
  }
}
