part of 'CalendarEventBloc.dart';

abstract class CalendarEventState extends Equatable {
  const CalendarEventState();
}

class CalendarEventLoaded extends CalendarEventState {
  final List<CalendarEventData<Event>> events;
  const CalendarEventLoaded({required this.events});

  @override
  // TODO: implement propss
  List<Object?> get props => [events];
}

class CalendarEventLoading extends CalendarEventState {
  //final List<CalendarEventData<Event>> events;
  const CalendarEventLoading();

  @override
  // TODO: implement propss
  List<Object?> get props => [];
}

class RegisteringServiceState extends CalendarEventState {
  const RegisteringServiceState();

  @override
  // TODO: implement propss
  List<Object?> get props => [];
}

class CalendarEventAdded extends CalendarEventState {
  final List<CalendarEventData<Event>> events;
  const CalendarEventAdded({required this.events});

  @override
  // TODO: implement propss
  List<Object?> get props => [events];
}
