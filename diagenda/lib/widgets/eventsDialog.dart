import 'package:diagenda/bloc/CalendarEvent/CalendarEventBloc.dart';
import 'package:diagenda/extension.dart';

import 'package:diagenda/model/event.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/pages/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EventDialog extends StatefulWidget {
  CalendarEventData<Event> event;
  EventDialog({Key? key, required this.event}) : super(key: key);

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //  backgroundColor: Colors.blueAccent.withOpacity(0.2),
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.only(right: 5.0, left: 5.0),

      content: Container(
          padding: const EdgeInsets.all(10.0),
          height: 350,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.blueAccent.withOpacity(0.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title:",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    widget.event.title,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Text(
                    "Importance:",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    widget.event.color.importanceColorReversed!.name.toString(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: widget.event.color,
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Text(
                    "From:",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      DateFormat.MMMMEEEEd()

                          // displaying formatted date
                          .format(widget.event.date)
                          .toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                      DateFormat.Hm()

                          // displaying formatted date
                          .format(widget.event.startTime as DateTime)
                          .toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Text(
                    "To:",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      DateFormat.MMMMEEEEd()

                          // displaying formatted date
                          .format(widget.event.endDate)
                          .toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                      DateFormat.Hm()

                          // displaying formatted date
                          .format(widget.event.endTime as DateTime)
                          .toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Text(
                    "Description:",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    //padding: EdgeInsets.all(5.0),
                    //width: 300,
                    constraints: const BoxConstraints(minHeight: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      // color: Colors.amberAccent.withOpacity(0.3),
                      // shape: BoxShape.circle
                    ),
                    child: Text(
                      widget.event.description,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          )),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<CalendarEventBloc>()
                    .add(DeleteCalendarEvent(event: widget.event));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const CalendarViewPage();
                    },
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ],
    );
  }
}
