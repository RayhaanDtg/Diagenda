part of 'CalendarEventBloc.dart';

@immutable
abstract class CalendarEventEvent extends Equatable {
  const CalendarEventEvent();
}

class DeleteCalendarEvent extends CalendarEventEvent {
  final CalendarEventData<Event> event;

  const DeleteCalendarEvent({required this.event});
  @override
  // TODO: implement propss
  List<Object?> get props => [event];
}

class SortEventList extends CalendarEventEvent {
  final int order;
  const SortEventList({required this.order});
  @override
  List<Object?> get props => [order];
}

class LoadCalendarEvent extends CalendarEventEvent {
  //final List<CalendarEventData<Event>> events;

  const LoadCalendarEvent();

  @override
  // TODO: implement propss
  List<Object?> get props => [];
}

class RegisterCalendarService extends CalendarEventEvent {
  const RegisterCalendarService();
  @override
  // TODO: implement propss
  List<Object?> get props => [];
}

class SearchEvent extends CalendarEventEvent {
  final String query;
  const SearchEvent({required this.query});
  @override
  // TODO: implement propss
  List<Object?> get props => [query];
}

class AddCalendarEvent extends CalendarEventEvent {
  final CalendarEventData<Event> event;
  // final ProductCategory category;
  const AddCalendarEvent({required this.event});

  @override
  // TODO: implement propss
  List<Object?> get props => [event];
}
