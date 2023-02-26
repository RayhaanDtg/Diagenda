// ignore: depend_on_referenced_packages
import 'package:diagenda/Repo/EventList.dart';
import 'package:diagenda/Repo/EventsRepository.dart';
import 'package:diagenda/model/event.dart';
import 'package:diagenda/services/NotificationServices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';

part 'CalendarEventEvent.dart';
part 'CalendarEventState.dart';

class CalendarEventBloc extends Bloc<CalendarEventEvent, CalendarEventState> {
  EventsRepository eventsRepository;
  CalendarEventBloc({required this.eventsRepository})
      //CalendarEventBloc()
      : super(const RegisteringServiceState()) {
    on<LoadCalendarEvent>(_onLoadCalendarEvent);
    on<AddCalendarEvent>(_onAddCalendarEvent);
    on<RegisterCalendarService>(_onRegisterServiceEvent);
    on<DeleteCalendarEvent>(_onDeleteCalendarEvent);
    on<SortEventList>(_onSortEventList);
    on<SearchEvent>(_onSearchEvent);
  }

  void _onDeleteCalendarEvent(event, Emitter<CalendarEventState> emit) async {
    await eventsRepository.deleteEvent(event.event);
    //emit(const CalendarEventLoading());
    emit(CalendarEventLoaded(events: eventsRepository.fetchEvents()));
  }

  void _onSearchEvent(event, Emitter<CalendarEventState> emit) {
    final state = this.state;
    List<CalendarEventData<Event>> events_temp = [];

    if (state is CalendarEventLoaded) {
      // notes_temp = state.notes.toList();
      //state.notes.any((element) => )
      for (var element in state.events) {
        if (element.title.toLowerCase().contains(event.query)) {
          events_temp.add(element);
        }
      }
    }

    emit(CalendarEventLoaded(events: events_temp));

    return;
  }

  void _onSortEventList(event, Emitter<CalendarEventState> emit) {
    final state = this.state;
    List<CalendarEventData<Event>> events_temp = [];

    if (state is CalendarEventLoaded) {
      events_temp = state.events.toList();
      if (event.order == 0) {
        events_temp.sort((a, b) => a.date.compareTo(b.date));
      } else {
        events_temp.sort((a, b) => b.date.compareTo(a.date));
      }
    }

    emit(CalendarEventLoaded(events: events_temp));

    return;
  }

  void _onRegisterServiceEvent(event, Emitter<CalendarEventState> emit) async {
    await eventsRepository.initDB();
    emit(const CalendarEventLoading());
    // emit(const CalendarEventLoading());
  }

  void _onLoadCalendarEvent(event, Emitter<CalendarEventState> emit) {
    // emit(const CalendarEventLoading());
    final events = eventsRepository.fetchEvents();
    // print(
    //     '--------------------------Printing the events fetched from hive for load----------------------------');
    // print(eventsRepository.fetchEvents());
    // print(
    //     '------------------Done Printing for load------------------------------');
    emit(CalendarEventLoaded(events: events));
  }

  void _onAddCalendarEvent(event, Emitter<CalendarEventState> emit) async {
    final state = this.state;
    //List<CalendarEventData<Event>> events_1;
    if (state is CalendarEventLoaded) {
      // events_1 = state.events;
      // events_1.add(event.event);
      // print(
      //     '--------------------------Printing the events calendar entered to hive for add----------------------------');
      // print(event.event);
      //trying the new events repo hive here
      eventsRepository.addEvent(event.event);
      // print(
      //     '--------------------------Printing the events fetched from hive for add----------------------------');
      // print(eventsRepository.fetchEvents());
      // print(
      //     '------------------Done Printing for add------------------------------');
      try {
        if (event.event.event.notification) {
          await NotificationService.scheduleNotification(
              event.event.startTime as DateTime,
              'Reminder 15 minutes before:',
              event.event.title);
        }
      } catch (e) {
        print(e);
        rethrow;
      }

      emit(CalendarEventAdded(events: eventsRepository.fetchEvents()));
      // print(
      //     'here in the bloc for calendar--------------------------------------------');
      // print(event.event);
      return;
    } else if (state is CalendarEventAdded) {
      // events_1 = state.events;
      // events_1.add(event.event);
      eventsRepository.addEvent(event.event);
      print(
          '--------------------------Printing the events fetched from hive----------------------------');
      print(eventsRepository.fetchEvents());
      print('------------------Done Printing------------------------------');

      if (event.event.event.notification) {
        await NotificationService.scheduleNotification(
            event.event.date, 'Title', 'Body');
      }
      emit(CalendarEventLoaded(events: eventsRepository.fetchEvents()));
      // print(
      //     'here in the bloc for calendar--------------------------------------------');
      // print(event.event);

      return;
    }
  }
}
