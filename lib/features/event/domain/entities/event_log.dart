class EventLog {
  final int LogID;
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

  EventLog({
    required this.LogID,
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
}
