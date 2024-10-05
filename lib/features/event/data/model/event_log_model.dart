// Used for handling json conversions
import 'dart:convert';

// Entity
import 'package:pod_app/features/event/domain/entities/event_log.dart';

class EventLogModel extends EventLog {
  EventLogModel({
    required super.LogID,
    required super.EventDate,
    required super.Operation,
    required super.Description,
    required super.UserID,
  });

  factory EventLogModel.fromJson(Map<String, dynamic> json) {
    return EventLogModel(
      LogID: json['LogID'],
      EventDate: json['EventDate'],
      Operation: json['Operation'],
      Description: json['Description'],
      UserID: json['UserID'],
    );
  }

  static List<EventLogModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((each) => EventLogModel.fromJson(each)).toList();
  }
}
