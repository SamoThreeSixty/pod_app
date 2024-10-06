import 'package:pod_app/features/cached/data/database/cached_image_dto.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CachedImageDatabase {
  // Singleton instance
  static final CachedImageDatabase instance = CachedImageDatabase._init();

  // Database instance
  Database? _database;

  CachedImageDatabase._init();

  // Data types
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';

  // Getter for database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cached_images.db');
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
      CREATE TABLE $tableCachedImages (
        ${CachedImageFields.id} $idType,
        ${CachedImageFields.name} $textType,
        ${CachedImageFields.localPath} $textType,
        ${CachedImageFields.createdAt} $textType,
        ${CachedImageFields.isSynced} $boolType,
        ${CachedImageFields.syncedAt} $textType,
        ${CachedImageFields.syncAction} $textType
      )
    ''');
  }

  Future<int> insertCachedImage(CachedImageDto imageDTO) async {
    final db = await instance.database;

    return await db.insert(
      'cached_images',
      imageDTO.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CachedImage>> fetchAllCachedImages() async {
    final db = await database;

    const orderBy = '${CachedImageFields.id} ASC';

    final List<Map<String, dynamic>> result =
        await db.query('cached_images', orderBy: orderBy);

    return result.map((json) => CachedImageDto.fromJson(json)).toList();
  }

  Future<void> deleteCachedImage(int id) async {
    final db = await instance.database;

    await db.delete(
      tableCachedImages,
      where: '${CachedImageFields.id} = ?',
      whereArgs: [id],
    );
  }
}
