import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/widgets/eventsDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../NotesDisplayNotfication.dart';
import '../bloc/CalendarEvent/CalendarEventBloc.dart';
import '../model/event.dart';

class DayViewWidget extends StatelessWidget {
  final GlobalKey<DayViewState>? state1;
  final double? width;

  const DayViewWidget({
    Key? key,
    this.state1,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventController<Event> controller = EventController<Event>();
    return BlocConsumer<CalendarEventBloc, CalendarEventState>(
      listener: (context, state) {
        if (state is CalendarEventLoading) {
          //return CircularProgressIndicator();
        } else if (state is CalendarEventAdded) {
          print('here listening to this shit');
          print('------------------------------------');
          print(state);
          print(state.events);
          controller.addAll(state.events);
        } else if (state is CalendarEventLoaded) {
          print('here listening to this shit');
          print('------------------------------------');
          print(state);
          print(state.events);
          controller.addAll(state.events);
        }
      },
      builder: (context, state) {
        if (state is CalendarEventLoading) {
          return const CircularProgressIndicator();
        } else if (state is CalendarEventAdded) {
          controller.addAll(state.events);
          print('here we are in bloc shit');
          print('------------------------------------');
          print(controller.events.last);
          print('------------------------------------');
        } else if (state is CalendarEventLoaded) {
          controller.addAll(state.events);
          print('here we are in bloc shit');
          print('------------------------------------');
          // print(controller.events.last);
          print('------------------------------------');
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.50,
          child: DayView<Event>(
            controller: controller,
            dateStringBuilder: (date, {secondaryDate}) {
              return DateFormat.yMMMEd()

                  // displaying formatted date
                  .format(date)
                  .toString();
            },
            key: state1,
            width: width,
            eventTileBuilder:
                (date, events, boundary, startDuration, endDuration) {
              if (events.isNotEmpty) {
                return RoundedEventTile(
                  borderRadius: BorderRadius.circular(6.0),
                  title: events[0].title,
                  titleStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  totalEvents: events.length,
                  description: events[0].description,
                  descriptionStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w300
                          //color: Colors.white,
                          ),
                  padding: const EdgeInsets.all(10.0),
                  backgroundColor: events[0].color.withOpacity(0.5),
                  margin: const EdgeInsets.all(2.0),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            onEventTap: (events, date) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EventDialog(event: events[0]);
                  });
            },
            onPageChange: (date, page) {
              DateSelectedNotification(date).dispatch(context);
            },
          ),
        );
      },
    );
  }

  List<CalendarEventData<Event>> _breakEvents() {
    List<CalendarEventData<Event>> newEventList = [];

    return newEventList;
  }
}
