part of 'event_log_bloc.dart';

// This is where you define the different states returned by the BLoC
// For simplicity here we have a failure and success defined here

@immutable
sealed class EventLogState {}

final class EventLogInitial extends EventLogState {}

final class EventLogFailure extends EventLogState {
  final String error;
  EventLogFailure(this.error);
}

final class EventLogSuccess extends EventLogState {
  final List<EventLog> eventLog;
  EventLogSuccess(this.eventLog);
}
