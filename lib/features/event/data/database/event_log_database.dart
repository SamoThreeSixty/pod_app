import 'dart:developer';
import 'package:pod_app/features/event/data/database/event_log_dto.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EventLogDatabase {
  // Singleton instance
  static final EventLogDatabase instance = EventLogDatabase._init();

  // Database instance
  Database? _database;

  EventLogDatabase._init();

// Data types
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';

  // Getter for database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('event_log.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDB);
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
        ${EventLogFields.UserID} $integerType,
        )
      ''');
  }

  // Create
  Future<EventLogDto> create(EventLogDto eventLog) async {
    final db = await instance.database;

    final id = await db.insert(tableEventLog, eventLog.toJson());
    return eventLog.copy(LogID: id);
  }

  // Read
  Future<EventLog> getDetail(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableEventLog,
      columns: EventLogFields.values,
      where: '${EventLogFields.LogID} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return EventLogDto.fromJson(maps.first);
    } else {
      throw Exception('LogID $id not found');
    }
  }

  // Read List
  Future<List<EventLog>> getList() async {
    final db = await instance.database;

    const orderBy = '${EventLogFields.LogID} ASC';

    final result = await db.query(tableEventLog, orderBy: orderBy);

    return result.map((json) => EventLogDto.fromJson(json)).toList();
  }

  // Update
  Future<int> update(EventLogDto eventLog) async {
    final db = await instance.database;

    return await db.update(
      tableEventLog,
      eventLog.toJson(),
      where: '${EventLogFields.LogID} = ?',
      whereArgs: [eventLog.LogID],
    );
  }

  // Delete
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEventLog,
      where: '${EventLogFields.LogID} = ?',
      whereArgs: [id],
    );
  }

  // Close the connection
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
