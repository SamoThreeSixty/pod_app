import 'package:pod_app/core/database/database.dart';
import 'package:pod_app/features/cached/data/database/cached_image_dto.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';
import 'package:sqflite/sqflite.dart';

class CachedImageDatabase {
  static final DatabaseHelper _instance = DatabaseHelper();

  Future<int> insertCachedImage(CachedImageDto imageDTO) async {
    final db = await _instance.database;

    return await db.insert(
      tableCachedImages,
      imageDTO.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CachedImage>> fetchAllCachedImages() async {
    final db = await _instance.database;

    const orderBy = '${CachedImageFields.id} ASC';

    final List<Map<String, dynamic>> result =
        await db.query(tableCachedImages, orderBy: orderBy);

    return result.map((json) => CachedImageDto.fromJson(json)).toList();
  }

  Future<void> deleteCachedImage(int id) async {
    final db = await _instance.database;

    await db.delete(
      tableCachedImages,
      where: '${CachedImageFields.id} = ?',
      whereArgs: [id],
    );
  }
}
