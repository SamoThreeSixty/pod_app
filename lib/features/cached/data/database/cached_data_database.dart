import 'package:pod_app/features/cached/data/database/cached_data_dto.dart';
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CachedDataDatabase {
  // Singleton instance
  static final CachedDataDatabase instance = CachedDataDatabase._init();

  // Database instance
  Database? _database;

  CachedDataDatabase._init();

  // Data types
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';

  // Getter for database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cached_data.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableCachedData (
        ${CachedDataFields.id} $idType,
        ${CachedDataFields.table} $textType,
        ${CachedDataFields.data} $textType,
        ${CachedDataFields.createdAt} $textType,
        ${CachedDataFields.isSynced} $boolType,
        ${CachedDataFields.syncedAt} $textType,
        ${CachedDataFields.syncAction} $textType
      )
    ''');
  }

  Future<int> insertCachedImage(CachedDataDto dataDTO) async {
    final db = await instance.database;

    return await db.insert(
      'cached_data',
      dataDTO.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CachedData>> fetchAllCachedImages() async {
    final db = await database;

    const orderBy = '${CachedDataFields.id} ASC';

    final List<Map<String, dynamic>> result =
        await db.query('cached_data', orderBy: orderBy);

    return result.map((json) => CachedDataDto.fromJson(json)).toList();
  }

  Future<void> deleteCachedImage(int id) async {
    final db = await instance.database;

    await db.delete(
      tableCachedData,
      where: '${CachedDataFields.id} = ?',
      whereArgs: [id],
    );
  }
}
