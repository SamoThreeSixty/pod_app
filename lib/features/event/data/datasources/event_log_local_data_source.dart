// Entities
import 'dart:developer';

import 'package:pod_app/features/event/data/database/event_log_database.dart';
import 'package:pod_app/features/event/data/datasources/event_log_data_source.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';

class EventLogLocalDataSourceImp implements EventLogDataSource {
  @override
  Future<List<EventLog>> getAllEventLogs() async {
    try {
      var db = EventLogDatabase.instance;
      final List<EventLog> eventLogs = await db.getList();
      return eventLogs;
    } catch (e) {
      throw Exception("Failed to fetch event logs : $e");
    }
  }
}
