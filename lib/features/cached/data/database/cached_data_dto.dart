import 'package:pod_app/features/cached/domain/entity/cached_data.dart';

const String tableCachedData = 'cached_data';

class CachedDataFields {
  static final List<String> values = [
    id,
    table,
    data,
    createdAt,
    isSynced,
    syncedAt,
    syncAction,
  ];

  static const String id = '_id';
  static const String table = 'table';
  static const String data = 'data';
  static const String createdAt = 'createdAt';
  static const String isSynced = 'isSynced';
  static const String syncedAt = 'syncedAt';
  static const String syncAction = 'syncAction';
}

class CachedDataDto {
  final int? id;
  final String? table;
  final String? data;
  final DateTime? createdAt;
  final bool? isSynced;
  final DateTime? syncedAt;
  final String? syncAction;

  const CachedDataDto({
    this.id,
    required this.table,
    required this.data,
    required this.createdAt,
    required this.isSynced,
    required this.syncedAt,
    required this.syncAction,
  });

  CachedDataDto copy({
    int? id,
    String? name,
    String? localPath,
    String? galleryPath,
    DateTime? createdAt,
    bool? isSynced,
    DateTime? syncedAt,
    String? syncAction,
  }) =>
      CachedDataDto(
        id: id ?? this.id,
        table: table ?? table,
        data: data ?? data,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
        syncedAt: syncedAt ?? this.syncedAt,
        syncAction: syncAction ?? this.syncAction,
      );

  factory CachedDataDto.fromEntity(CachedData cachedData) {
    return CachedDataDto(
      id: cachedData.id,
      table: cachedData.table,
      data: cachedData.data,
      createdAt: cachedData.createdAt,
      isSynced: cachedData.isSynced,
      syncedAt: cachedData.syncedAt,
      syncAction: cachedData.syncAction,
    );
  }

  static CachedData fromJson(Map<String, Object?> json) => CachedData(
        id: json['_id'] as int,
        table: json['table'] as String,
        data: json['data'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        isSynced: json['isSynced'] as bool,
        syncedAt: DateTime.parse(json['syncedAt'] as String),
        syncAction: json['syncAction'] as String,
      );

  Map<String, Object?> toJson() => {
        CachedDataFields.id: id,
        CachedDataFields.table: table,
        CachedDataFields.data: data,
        CachedDataFields.createdAt: createdAt!.toIso8601String(),
        CachedDataFields.isSynced: isSynced,
        CachedDataFields.syncedAt: syncedAt!.toIso8601String(),
        CachedDataFields.syncAction: syncAction,
      };
}
