import 'package:pod_app/features/event/data/datasources/event_log_data_source.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';

class EventLogRemoteDataSourceImp implements EventLogDataSource {
  @override
  Future<List<EventLog>> getAllEventLogs() {
    // TODO: implement getAllEventLogs
    throw UnimplementedError();
  }
}
