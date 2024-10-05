import 'package:fpdart/src/either.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';
import 'package:pod_app/features/event/domain/repository/event_repository.dart';

class GetAllEventLogs implements UseCase<List<EventLog>, NoParams> {
  final EventLogRepository eventRepository;
  GetAllEventLogs(this.eventRepository);

  @override
  Future<Either<Failure, List<EventLog>>> call(NoParams params) {
    return eventRepository.getAllEventLogs();
  }
}
