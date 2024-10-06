class CachedData {
  int id;
  String table;
  String data;
  DateTime createdAt;
  bool isSynced;
  DateTime? syncedAt;
  String syncAction; // 'create', 'update', 'delete'

  CachedData({
    required this.id,
    required this.table,
    required this.data,
    required this.createdAt,
    this.isSynced = false,
    this.syncedAt,
    required this.syncAction,
  });
}
