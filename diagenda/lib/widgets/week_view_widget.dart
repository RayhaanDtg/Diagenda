import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/widgets/eventsDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../NotesDisplayNotfication.dart';
import '../bloc/CalendarEvent/CalendarEventBloc.dart';
import '../model/event.dart';

class WeekViewWidget extends StatelessWidget {
  final GlobalKey<WeekViewState>? state1;
  final double? width;

  const WeekViewWidget({Key? key, this.state1, this.width}) : super(key: key);

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
          return CircularProgressIndicator();
        } else if (state is CalendarEventAdded) {
          controller.addAll(state.events);
        } else if (state is CalendarEventLoaded) {
          controller.addAll(state.events);
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: WeekView<Event>(
            headerStringBuilder: (date, {secondaryDate}) {
              return DateFormat.MMMMEEEEd().format(date) +
                  ' to ' +
                  DateFormat.yMMMEd().format(secondaryDate as DateTime);
            },
            controller: controller,
            key: state1,
            width: width,
            eventTileBuilder:
                (date, events, boundary, startDuration, endDuration) {
              if (events.isNotEmpty) {
                return RoundedEventTile(
                  backgroundColor: events[0].color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6.0),
                  title: events[0].title,
                  titleStyle:
                      const TextStyle(fontSize: 10, fontWeight: FontWeight.w500
                          //color: Colors.white,
                          ),
                  totalEvents: events.length,
                  padding: const EdgeInsets.all(5.0),
                );
              } else {
                return Container();
              }
            },
            onDateTap: (date) {
              DateSelectedNotification(date).dispatch(context);
            },
            onEventTap: (events, date) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EventDialog(event: events[0]);
                  });
            },
          ),
        );
      },
    );
  }
}
