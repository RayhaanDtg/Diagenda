import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/model/event.dart';

import '../model/HiveEvent.dart';
import '../services/CalendarEventService.dart';

abstract class IEventsRepository {
  Future<void> initDB();

  List<CalendarEventData<Event>> fetchEvents();

  void addEvent(CalendarEventData<Event> event);

  void deleteEvent(CalendarEventData<Event> event);
}

class EventsRepository extends IEventsRepository {
  EventsRepository({required this.hiveService});
  final CalendarEventService hiveService;
  List<CalendarEventData<Event>> events = [];

  @override
  Future<void> initDB() async {
    await hiveService.init();
  }

  @override
  List<CalendarEventData<Event>> fetchEvents() {
    List<HiveEvent> entityEvents = hiveService.getAll();
    events = entityEvents.map((e) => e.toCalendarEvent()).toList();
    // print(
    //     '---------------here in repo printing colors------------------------------');
    // entityEvents.map((e) => print(e.toCalendarEvent())).toList();

    // print(events);
    // print(
    //     '---------------------------done printing repo----------------------');
    return events;
  }

  @override
  void addEvent(CalendarEventData<Event> event) {
    hiveService.add(HiveEvent.fromCalendarEvent(event));
  }

  @override
  Future<void> deleteEvent(CalendarEventData<Event> event) async {
    await hiveService.delete(event.event!.key as int);
  }

  // @override
  // List<Notes> getNotesbyDate(DateTime date) {
  //   notes = hiveService.getAll();
  //   return notes.where((note) => note.timestamp.day == date.day).toList();
  // }
}
