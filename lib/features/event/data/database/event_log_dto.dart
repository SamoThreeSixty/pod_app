import 'package:pod_app/features/event/domain/entities/event_log.dart';

const String tableEventLog = 'event_log';

class EventLogFields {
  static final List<String> values = [
    LogID,
    EventDate,
    Operation,
    Description,
    UserID,
  ];

  static const String LogID = '_LogID'; // This indicates it as the primary key
  static const String EventDate = 'EventDate';
  static const String Operation = 'Operation';
  static const String Description = 'Description';
  static const String UserID = 'UserID';
}

class EventLogDto {
  final int? LogID;
  final DateTime EventDate;
  final String Operation;
  final String Description;
  final int UserID;

  //TODO: what is this const method doing. Is it basically a constructor?
  const EventLogDto({
    this.LogID,
    required this.EventDate,
    required this.Operation,
    required this.Description,
    required this.UserID,
  });

  // TODO: what does this do, does it create a deep copy?
  EventLogDto copy({
    int? LogID,
    DateTime? EventDate,
    String? Operation,
    String? Description,
    int? UserID,
  }) =>
      EventLogDto(
        LogID: LogID ?? this.LogID,
        EventDate: EventDate ?? this.EventDate,
        Operation: Operation ?? this.Operation,
        Description: Description ?? this.Description,
        UserID: UserID ?? this.UserID,
      );

  // Convert to the entity object when returning
  static EventLog fromJson(Map<String, Object?> json) => EventLog(
        LogID: json['_LogID'] as int,
        EventDate: DateTime.parse(json['EventDate'] as String),
        Operation: json['Operation'] as String,
        Description: json['Description'] as String,
        UserID: json['UserID'] as int,
      );

  Map<String, Object?> toJson() => {
        EventLogFields.LogID: LogID,
        EventLogFields.EventDate: EventDate.toIso8601String(),
        EventLogFields.Operation: Operation,
        EventLogFields.Description: Description,
        EventLogFields.UserID: UserID,
      };
}
