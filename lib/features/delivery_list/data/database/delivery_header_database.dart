import 'package:pod_app/features/delivery_list/data/database/delivery_header_dto.dart';
import 'package:pod_app/features/delivery_list/data/model/delivery_header_model.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DeliveryHeaderDatabase {
  // Singleton instance
  static final DeliveryHeaderDatabase instance = DeliveryHeaderDatabase._init();

  // Database instance
  Database? _database;

  DeliveryHeaderDatabase._init();

  // Data types
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';

  // Getter for database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('delivery_header.db');
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
      CREATE TABLE $tableDeliveryHeader (
        ${DeliveryHeaderFields.id} $idType,
        ${DeliveryHeaderFields.status} $integerType,
        ${DeliveryHeaderFields.created_at} $textType,
        ${DeliveryHeaderFields.customer} $textType,
        ${DeliveryHeaderFields.address_line_1} $textType,
        ${DeliveryHeaderFields.address_line_2} $textType,
        ${DeliveryHeaderFields.city} $textType,
        ${DeliveryHeaderFields.region} $textType,
        ${DeliveryHeaderFields.postcode} $textType,
        ${DeliveryHeaderFields.country} $textType,
        ${DeliveryHeaderFields.lat} $integerType,
        ${DeliveryHeaderFields.long} $integerType,
        ${DeliveryHeaderFields.route_id} $integerType,
        ${DeliveryHeaderFields.vehicle_id} $integerType,
      )
    ''');
  }

  // Insert a new delivery header into the database
  Future<int> insertDeliveryHeader(DeliveryHeaderDto header) async {
    final db = await instance.database;

    return await db.insert(
      'delivery_headers',
      header.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all delivery headers from the database
  Future<List<DeliveryHeader>> fetchAllDeliveryHeaders() async {
    final db = await database;

    const orderBy = '${DeliveryHeaderFields.id} ASC';

    final List<Map<String, dynamic>> result =
        await db.query('delivery_headers', orderBy: orderBy);

    return result.map((json) => DeliveryHeaderDto.fromJson(json)).toList();
  }

  // Delete a delivery header by ID
  Future<void> deleteDeliveryHeader(int id) async {
    final db = await instance.database;

    await db.delete(
      tableDeliveryHeader,
      where: '${DeliveryHeaderFields.id} = ?',
      whereArgs: [id],
    );
  }
}
