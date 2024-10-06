class CachedData {
  int id;
  String name;
  String localPath;
  String galleryPath;
  DateTime createdAt;
  bool isSynced;
  DateTime? syncedAt;
  String syncAction; // 'create', 'update', 'delete'

  CachedData({
    required this.id,
    required this.name,
    required this.localPath,
    required this.galleryPath,
    required this.createdAt,
    this.isSynced = false,
    this.syncedAt,
    required this.syncAction,
  });
}
