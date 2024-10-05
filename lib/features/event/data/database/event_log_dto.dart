import 'package:pod_app/features/event/domain/entities/event_log.dart';

const String tableEventLog = 'event_log';

class EventLogFields {
  static final List<String> values = [
    LogID,
    EventDate,
    ModuleName,
    Operation,
    Description,
    ShortDesc,
    UserID,
    FreeType,
    SystemEvent,
    Table,
    KeyValue,
    SessionID,
    System,
  ];

  static const String LogID = '_LogID'; // This indicates it as the primary key
  static const String EventDate = 'EventDate';
  static const String ModuleName = 'ModuleName';
  static const String Operation = 'Operation';
  static const String Description = 'Description';
  static const String ShortDesc = 'ShortDesc';
  static const String UserID = 'UserID';
  static const String FreeType = 'FreeType';
  static const String SystemEvent = 'SystemEvent';
  static const String Table = 'DatabaseTable';
  static const String KeyValue = 'KeyValue';
  static const String SessionID = 'SessionID';
  static const String System = 'System';
}

class EventLogDto {
  final int? LogID;
  final DateTime EventDate;
  final String ModuleName;
  final String Operation;
  final String Description;
  final String ShortDesc;
  final int UserID;
  final String FreeType;
  final String SystemEvent;
  final String Table;
  final String KeyValue;
  final int SessionID;
  final String System;

  //TODO: what is this const method doing. Is it basically a constructor?
  const EventLogDto({
    this.LogID,
    required this.EventDate,
    required this.ModuleName,
    required this.Operation,
    required this.Description,
    required this.ShortDesc,
    required this.UserID,
    required this.FreeType,
    required this.SystemEvent,
    required this.Table,
    required this.KeyValue,
    required this.SessionID,
    required this.System,
  });

  // TODO: what does this do, does it create a deep copy?
  EventLogDto copy({
    int? LogID,
    DateTime? EventDate,
    String? ModuleName,
    String? Operation,
    String? Description,
    String? ShortDesc,
    int? UserID,
    String? FreeType,
    String? SystemEvent,
    String? Table,
    String? KeyValue,
    int? SessionID,
    String? System,
  }) =>
      EventLogDto(
        LogID: LogID ?? this.LogID,
        EventDate: EventDate ?? this.EventDate,
        ModuleName: ModuleName ?? this.ModuleName,
        Operation: Operation ?? this.Operation,
        Description: Description ?? this.Description,
        ShortDesc: ShortDesc ?? this.ShortDesc,
        UserID: UserID ?? this.UserID,
        FreeType: FreeType ?? this.FreeType,
        SystemEvent: SystemEvent ?? this.SystemEvent,
        Table: Table ?? this.Table,
        KeyValue: KeyValue ?? this.KeyValue,
        SessionID: SessionID ?? this.SessionID,
        System: System ?? this.System,
      );

  // Convert to the entity object when returning
  static EventLog fromJson(Map<String, Object?> json) => EventLog(
        LogID: json['_LogID'] as int,
        EventDate: DateTime.parse(json['EventDate'] as String),
        ModuleName: json['ModuleName'] as String,
        Operation: json['Operation'] as String,
        Description: json['Description'] as String,
        ShortDesc: json['ShortDesc'] as String,
        UserID: json['UserID'] as int,
        FreeType: json['FreeType'] as String,
        SystemEvent: json['SystemEvent'] as String,
        Table: json['DatabaseTable'] as String,
        KeyValue: json['KeyValue'] as String,
        SessionID: json['SessionID'] as int,
        System: json['System'] as String,
      );

  Map<String, Object?> toJson() => {
        EventLogFields.LogID: LogID,
        EventLogFields.EventDate: EventDate.toIso8601String(),
        EventLogFields.ModuleName: ModuleName,
        EventLogFields.Operation: Operation,
        EventLogFields.Description: Description,
        EventLogFields.ShortDesc: ShortDesc,
        EventLogFields.UserID: UserID,
        EventLogFields.FreeType: FreeType,
        EventLogFields.SystemEvent: SystemEvent,
        EventLogFields.Table: Table,
        EventLogFields.KeyValue: KeyValue,
        EventLogFields.SessionID: SessionID,
        EventLogFields.System: System,
      };
}
