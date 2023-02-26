import 'package:flutter/material.dart';

class CalendarNotification extends Notification {
  final Widget widget;
  CalendarNotification(this.widget);
}

class MonthViewNotification extends CalendarNotification {
  @override
  final Widget widget;
  MonthViewNotification(this.widget) : super(widget);
}

class DayViewNotification extends CalendarNotification {
  @override
  final Widget widget;
  DayViewNotification(this.widget) : super(widget);
}

class WeekViewNotification extends CalendarNotification {
  @override
  final Widget widget;
  WeekViewNotification(this.widget) : super(widget);
}
