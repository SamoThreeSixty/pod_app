import 'package:pod_app/core/database/database.dart';
import 'package:pod_app/features/event/data/database/event_log_dto.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';
import 'package:sqflite/sqflite.dart';

class EventLogDatabase {
  static final DatabaseHelper _instance = DatabaseHelper();

  // Create
  Future<EventLogDto> create(EventLogDto eventLog) async {
    final db = await _instance.database;

    final id = await db.insert(tableEventLog, eventLog.toJson());
    return eventLog.copy(LogID: id);
  }

  // Read
  Future<EventLog> getDetail(int id) async {
    final db = await _instance.database;

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
    final db = await _instance.database;

    const orderBy = '${EventLogFields.LogID} ASC';

    final result = await db.query(tableEventLog, orderBy: orderBy);

    return result.map((json) => EventLogDto.fromJson(json)).toList();
  }

  // Update
  Future<int> update(EventLogDto eventLog) async {
    final db = await _instance.database;

    return await db.update(
      tableEventLog,
      eventLog.toJson(),
      where: '${EventLogFields.LogID} = ?',
      whereArgs: [eventLog.LogID],
    );
  }

  // Delete
  Future<int> delete(int id) async {
    final db = await _instance.database;

    return await db.delete(
      tableEventLog,
      where: '${EventLogFields.LogID} = ?',
      whereArgs: [id],
    );
  }
}
