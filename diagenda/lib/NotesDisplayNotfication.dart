import 'package:flutter/material.dart';

class NotesDisplayNotificiation extends Notification {
  final DateTime date;
  NotesDisplayNotificiation(this.date);
}

class DateSelectedNotification extends NotesDisplayNotificiation {
  @override
  final DateTime date;
  DateSelectedNotification(this.date) : super(date);
}
