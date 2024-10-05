// TODO: what does this do exactly?
import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';

abstract interface class EventLogRepository {
  Future<Either<Failure, List<EventLog>>> getAllEventLogs();
}
