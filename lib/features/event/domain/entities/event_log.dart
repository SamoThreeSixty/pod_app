class EventLog {
  final int LogID;
  final DateTime EventDate;
  final String Operation;
  final String Description;
  final int UserID;

  EventLog({
    required this.LogID,
    required this.EventDate,
    required this.Operation,
    required this.Description,
    required this.UserID,
  });
}
