// Used for handling json conversions
import 'dart:convert';

// Entity
import 'package:pod_app/features/event/domain/entities/event_log.dart';

class EventLogModel extends EventLog {
  EventLogModel({
    required super.LogID,
    required super.EventDate,
    required super.ModuleName,
    required super.Operation,
    required super.Description,
    required super.ShortDesc,
    required super.UserID,
    required super.FreeType,
    required super.SystemEvent,
    required super.Table,
    required super.KeyValue,
    required super.SessionID,
    required super.System,
  });

  factory EventLogModel.fromJson(Map<String, dynamic> json) {
    return EventLogModel(
      LogID: json['LogID'],
      EventDate: json['EventDate'],
      ModuleName: json['ModuleName'],
      Operation: json['Operation'],
      Description: json['Description'],
      ShortDesc: json['ShortDesc'],
      UserID: json['UserID'],
      FreeType: json['FreeType'],
      SystemEvent: json['SystemEvent'],
      Table: json['Table'],
      KeyValue: json['KeyValue'],
      SessionID: json['SessionID'],
      System: json['System'],
    );
  }

  static List<EventLogModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((each) => EventLogModel.fromJson(each)).toList();
  }
}
