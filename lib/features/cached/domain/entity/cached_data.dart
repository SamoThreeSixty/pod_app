class CachedData {
  int id;
  String data;
  DateTime createdAt;
  bool isSynced;
  DateTime? syncedAt;
  String syncAction; // 'create', 'update', 'delete'

  CachedData({
    required this.id,
    required this.data,
    required this.createdAt,
    this.isSynced = false,
    this.syncedAt,
    required this.syncAction,
  });
}
