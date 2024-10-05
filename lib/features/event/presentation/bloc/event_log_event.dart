part of 'event_log_bloc.dart';

// This is where you handle the different events or calls that will be
// made to the BLoC.

@immutable
sealed class EventLogEvent {}

final class DataGetAllEvents extends EventLogEvent {}

final class LogEvent extends EventLogEvent {
  final String message;

  LogEvent(this.message);
}
