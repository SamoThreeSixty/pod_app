import 'package:pod_app/features/event/domain/entities/event_log.dart';

abstract interface class EventLogDataSource {
  Future<List<EventLog>> getAllEventLogs();
}
