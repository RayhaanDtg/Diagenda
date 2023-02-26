import 'package:hive/hive.dart';

import '../model/HiveEvent.dart';

class CalendarEventService {
  late Box<HiveEvent> _calendarEvents;

  Future<void> init() async {
    try {
      // Hive.resetAdapters();
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(HiveEventAdapter());
      }

      _calendarEvents = await Hive.openBox('Events');
      print('-------------------printed----------------------');
      print(_calendarEvents.isOpen);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  List<HiveEvent> getAll() {
    try {
      final event_lst = _calendarEvents.values;
      return event_lst.toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void add(HiveEvent event) {
    _calendarEvents.add(event);
  }

  Future<void> delete(int index) async {
    try {
      final deleteNote = _calendarEvents.values
          .firstWhere((element) => element.key as int == index);
      await deleteNote.delete();
    } catch (e) {
      rethrow;
    }
  }
}
