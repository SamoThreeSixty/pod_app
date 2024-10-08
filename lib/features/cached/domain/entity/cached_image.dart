class CachedImage {
  int? id;
  String name;
  String localPath;
  DateTime createdAt;
  bool isSynced;
  DateTime? syncedAt;
  String syncAction; // 'create', 'update', 'delete'

  CachedImage({
    this.id,
    required this.name,
    required this.localPath,
    required this.createdAt,
    this.isSynced = false,
    this.syncedAt,
    required this.syncAction,
  });
}
