import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/event/data/datasources/event_log_data_source.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';
import 'package:pod_app/features/event/domain/repository/event_repository.dart';

class EventLogRepositoryImp implements EventLogRepository {
  final EventLogDataSource eventLogRemoteDataSource;
  final EventLogDataSource eventLogLocalDataSource;

  EventLogRepositoryImp({
    required this.eventLogRemoteDataSource,
    required this.eventLogLocalDataSource,
  });

  @override
  Future<Either<Failure, List<EventLog>>> getAllEventLogs() async {
    try {
      List<EventLog> result;

      // For testing, just use local

      result = await eventLogLocalDataSource.getAllEventLogs();

      // if (connectionStatus == ConnectivityResult.none) {
      //   result = await eventLogLocalDataSource.getAllEventLogs();
      // } else {
      //   result = await eventLogRemoteDataSource.getAllEventLogs();
      // }
      return right(result);
    } catch (error) {
      return left(
        Failure(
          error.toString(),
        ),
      );
    }
  }
}
