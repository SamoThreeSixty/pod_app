import 'package:pod_app/features/cached/domain/entity/cached_image.dart';

const String tableCachedImages = 'cached_images';

class CachedImageFields {
  static final List<String> values = [
    id,
    name,
    localPath,
    createdAt,
    isSynced,
    syncedAt,
    syncAction,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String localPath = 'localPath';
  static const String createdAt = 'createdAt';
  static const String isSynced = 'isSynced';
  static const String syncedAt = 'syncedAt';
  static const String syncAction = 'syncAction';
}

class CachedImageDto {
  final int? id;
  final String? name;
  final String? localPath;
  final DateTime? createdAt;
  final bool? isSynced;
  final DateTime? syncedAt;
  final String? syncAction;

  const CachedImageDto({
    this.id,
    required this.name,
    required this.localPath,
    required this.createdAt,
    required this.isSynced,
    required this.syncedAt,
    required this.syncAction,
  });

  CachedImageDto copy({
    int? id,
    String? name,
    String? localPath,
    String? galleryPath,
    DateTime? createdAt,
    bool? isSynced,
    DateTime? syncedAt,
    String? syncAction,
  }) =>
      CachedImageDto(
        id: id ?? this.id,
        name: name ?? this.name,
        localPath: localPath ?? this.localPath,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
        syncedAt: syncedAt ?? this.syncedAt,
        syncAction: syncAction ?? this.syncAction,
      );

  factory CachedImageDto.fromEntity(CachedImage cachedImage) {
    return CachedImageDto(
      id: cachedImage.id,
      name: cachedImage.name,
      localPath: cachedImage.localPath,
      createdAt: cachedImage.createdAt,
      isSynced: cachedImage.isSynced,
      syncedAt: cachedImage.syncedAt,
      syncAction: cachedImage.syncAction,
    );
  }

  static CachedImage fromJson(Map<String, Object?> json) => CachedImage(
        id: json['_id'] as int,
        name: json['name'] as String,
        localPath: json['localPath'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        isSynced: json['isSynced'] == 1 ? true : false,
        syncedAt: DateTime.parse(json['eventDate'] as String),
        syncAction: json['syncAction'] as String,
      );

  Map<String, Object?> toJson() => {
        CachedImageFields.id: id,
        CachedImageFields.name: name,
        CachedImageFields.localPath: localPath,
        CachedImageFields.createdAt: createdAt!.toIso8601String(),
        CachedImageFields.isSynced: isSynced == true ? 1 : 0,
        CachedImageFields.syncedAt:
            syncedAt == null ? '' : syncedAt?.toIso8601String(),
        CachedImageFields.syncAction: syncAction,
      };
}
