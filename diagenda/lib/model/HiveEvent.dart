import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/enumerations.dart';
import 'package:diagenda/model/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

import 'package:hive/hive.dart';
import '../extension.dart';

part 'HiveEvent.g.dart';

@HiveType(typeId: 1)
class HiveEvent extends HiveObject with EquatableMixin {
  /// Specifies date on which all these events are.
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  DateTime endTime;

  /// Title of the event.
  @HiveField(3)
  String title;

  @HiveField(4)
  int importanceLevel;

  /// Description of the event.
  @HiveField(5)
  String description;

  @HiveField(6)
  DateTime endDate;

  @HiveField(7)
  bool notification;

  /// Stores all the events on [date]
  HiveEvent(
      {required this.importanceLevel,
      required this.title,
      required this.description,
      required this.startTime,
      required this.endTime,
      required this.endDate,
      required this.date,
      required this.notification});

  // DateTime get endDate => _endDate ?? date;

  factory HiveEvent.fromCalendarEvent(CalendarEventData<Event> event) {
    return HiveEvent(
        title: event.title,
        description: event.description,
        startTime: event.startTime as DateTime,
        endTime: event.endTime as DateTime,
        notification: event.event!.notification,
        endDate: event.endDate,
        date: event.date,
        importanceLevel: event.color.importanceColorReversed!.index);
  }

  CalendarEventData<Event> toCalendarEvent() {
    return CalendarEventData<Event>(
        title: title,
        color: ImportanceLevel.values[importanceLevel].importanceColor as Color,
        date: date,
        description: description,
        startTime: startTime,
        endDate: endDate,
        endTime: endTime,
        event: Event(
            importanceLevel: ImportanceLevel.values[importanceLevel],
            key: key,
            title: title,
            notification: notification));
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "title": title,
        "description": description,
        "endDate": endDate,
      };

  @override
  String toString() => toJson().toString();

  @override
  int get hashCode => super.hashCode;

  @override
  // TODO: implement props
  List<Object?> get props => [key];
}
