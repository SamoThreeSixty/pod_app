import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Tables
import 'package:pod_app/features/cached/data/database/cached_image_dto.dart';
import 'package:pod_app/features/event/data/database/event_log_dto.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Database instance
  Database? _database;

  // Private constructor
  DatabaseHelper._internal();

  // Factory gives access to the same function
  factory DatabaseHelper() => _instance;

  // Initialise and return the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pod_app.db');
    return _database!;
  }

  // Data types
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final textTypeNullable = 'TEXT';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';

  // Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 2, onCreate: _createDB);
  }

  // Create the database if not already present
  Future _createDB(Database db, int version) async {
    // Database structure
    await db.execute('''

      CREATE TABLE $tableEventLog ( 
        ${EventLogFields.LogID} $idType, 
        ${EventLogFields.EventDate} $textType,
        ${EventLogFields.Operation} $integerType,
        ${EventLogFields.Description} $textType,
        ${EventLogFields.UserID} $integerType
        );


      CREATE TABLE $tableCachedImages (
        ${CachedImageFields.id} $idType,
        ${CachedImageFields.name} $textType,
        ${CachedImageFields.localPath} $textType,
        ${CachedImageFields.createdAt} $textType,
        ${CachedImageFields.isSynced} $boolType,
        ${CachedImageFields.syncedAt} $textTypeNullable,
        ${CachedImageFields.syncAction} $textType
        );

      ''');
  }

  // Close the connection
  Future close() async {
    final db = await _instance.database;

    db.close();
  }
}
