import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/event/domain/entities/event_log.dart';
import 'package:pod_app/features/event/domain/usecase/get_all_event_logs.dart';

part 'event_log_event.dart';
part 'event_log_state.dart';

class EventLogBloc extends Bloc<EventLogEvent, EventLogState> {
  final GetAllEventLogs _getAllEventLogs;

  EventLogBloc({required GetAllEventLogs getAllEventLogs})
      : _getAllEventLogs = getAllEventLogs,
        super(EventLogInitial()) {
    on<DataGetAllEvents>(_onGetAllEventLogs);
  }

  void _onGetAllEventLogs(
    DataGetAllEvents event,
    Emitter<EventLogState> emit,
  ) async {
    final res = await _getAllEventLogs(NoParams());

    res.fold(
      (l) => emit(EventLogFailure(l.message)),
      (r) => emit(EventLogSuccess(r)),
    );
  }
}
