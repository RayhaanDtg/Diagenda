import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/bloc/CalendarEvent/CalendarEventBloc.dart';
import 'package:diagenda/widgets/eventsDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//import '../bloc/CalendarEvent/CalendarEventBloc.dart';
import '../NotesDisplayNotfication.dart';
import '../model/event.dart';

class MonthViewWidget extends StatelessWidget {
  final GlobalKey<MonthViewState>? state1;
  final double? width;

  const MonthViewWidget({
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
        } else if (state is CalendarEventLoaded) {
          print('here listening to this shit');
          print('------------------------------------');
          print(state);
          print(state.events);
          controller.addAll(state.events);
        } else if (state is CalendarEventAdded) {
          controller.addAll(state.events);
          print('here listening to this shit');
          print('------------------------------------');
          print(state);
          print(state.events);
        }
      },
      builder: (context, state) {
        if (state is CalendarEventLoading) {
          return CircularProgressIndicator();
        } else if (state is CalendarEventLoaded) {
          controller.addAll(state.events);
        } else if (state is CalendarEventAdded) {
          controller.addAll(state.events);
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.50,
          child: MonthView<Event>(
            controller: controller,
            key: state1,
            //cellAspectRatio: 1.1,
            width: width,
            headerStringBuilder: (date, {secondaryDate}) {
              return DateFormat.LLLL().format(date) +
                  '-' +
                  date.year.toString();
            },
            cellBuilder: (date, event, isToday, isInMonth) {
              return FilledCell(
                shouldHighlight: isToday,
                backgroundColor:
                    isInMonth ? Colors.white : const Color(0xfff0f0f0),
                date: date,
                events: event,
                tileColor: Colors.black,
                onTileTap: (event, date) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EventDialog(event: event);
                      });
                },
              );
            },

            onCellTap: (events, date) {
              DateSelectedNotification(date).dispatch(context);
            },
          ),
        );
      },
    );
  }

  String createHeader(DateTime? date) {
    return '';
  }
}
