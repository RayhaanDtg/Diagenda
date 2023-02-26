import 'package:diagenda/model/Notes.dart';
import 'package:diagenda/model/event.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventWidget extends StatefulWidget {
  CalendarEventData<Event> event;
  EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
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
    return Container(
        padding: const EdgeInsets.all(8.0),
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blueAccent.withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    widget.event.title,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                // const SizedBox(
                //   width: 75.0,
                // ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: widget.event.color,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                      DateFormat.MMMMEEEEd()

                          // displaying formatted date
                          .format(widget.event.date)
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
                // const SizedBox(
                //   width: 75.0,
                // ),
                Flexible(
                  child: Text(
                      DateFormat.Hm()

                          // displaying formatted date
                          .format(widget.event.startTime as DateTime)
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                      DateFormat.MMMMEEEEd()

                          // displaying formatted date
                          .format(widget.event.endDate)
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
                // const SizedBox(
                //   width: 75.0,
                // ),
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
            )
          ],
        ));
  }
}
