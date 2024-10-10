import 'package:pod_app/core/database/database.dart';
import 'package:pod_app/features/cached/data/database/cached_data_dto.dart';
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:sqflite/sqflite.dart';

class CachedDataDatabase {
  static final DatabaseHelper _instance = DatabaseHelper();

  Future<int> insertCachedImage(CachedDataDto dataDTO) async {
    final db = await _instance.database;

    return await db.insert(
      'cached_data',
      dataDTO.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CachedData>> fetchAllCachedImages() async {
    final db = await _instance.database;

    const orderBy = '${CachedDataFields.id} ASC';

    final List<Map<String, dynamic>> result =
        await db.query('cached_data', orderBy: orderBy);

    return result.map((json) => CachedDataDto.fromJson(json)).toList();
  }

  Future<void> deleteCachedImage(int id) async {
    final db = await _instance.database;

    await db.delete(
      tableCachedData,
      where: '${CachedDataFields.id} = ?',
      whereArgs: [id],
    );
  }
}
