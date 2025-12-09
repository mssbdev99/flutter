import '../../../core/app_export.dart';

const String eventTable = 'schedule';

class EventFields {
  
  static final List<String> values = [id, eventName, eventLocation, eventClub, eventStart, eventEnd];

  static const String id = 'id';
  static const String eventName = 'name';
  static const String eventLocation = 'location';
  static const String eventClub = 'club';
  static const String eventStart = 'start';
  static const String eventEnd = 'end';
  
}

class ScheduleItemModel {
  ScheduleItemModel({
    this.eventName,
    this.eventLocation,
    this.eventClub,
    this.eventStart,
    this.eventEnd,
    this.id,
  });

  ScheduleItemModel copy({
    int? id,
    String? eventName,
    String? eventLocation,
    String? eventClub,
    DateTime? eventStart,
    DateTime? eventEnd,
  }) =>
      ScheduleItemModel(
        eventName: eventName ?? this.eventName,
        eventLocation: eventLocation ?? this.eventLocation,
        eventClub: eventClub ?? ImageConstant.imgProfilePicture,
        eventStart: this.eventStart,
        eventEnd: this.eventEnd,
        id: id ?? this.id,
      );

  String? eventName;

  String? eventLocation;

  String? eventClub;

  DateTime? eventStart;

  DateTime? eventEnd;

  int? id;

  static ScheduleItemModel fromJson(Map<String, Object?> json) =>
      ScheduleItemModel(
        id: json[EventFields.id] as int?,
        eventName: json[EventFields.eventName] as String,
        eventLocation: json[EventFields.eventLocation] as String,
        eventClub: json[EventFields.eventClub] as String,
        eventStart: DateTime.parse(json[EventFields.eventStart] as String),
        eventEnd: DateTime.parse(json[EventFields.eventEnd] as String),
      );

  Map<String, Object?> toJson() => {
        EventFields.id: id,
        EventFields.eventName: eventName,
        EventFields.eventLocation: eventLocation,
        EventFields.eventClub: eventClub,
        EventFields.eventStart: eventStart?.toIso8601String(),
        EventFields.eventEnd: eventEnd?.toIso8601String(),
      };
}
