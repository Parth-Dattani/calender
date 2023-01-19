import 'package:flutter/material.dart';

class Meeting{
  Meeting(
        this.eventName,
       this.from,
       this.to,
       this.background,
       this.isAllDay
   );

  // String event;
  // DateTime startDate;
  // DateTime endDate;
  // Color eventColor;
  // bool isAllDat;

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}


class Event {
  final String eventName;
  final String eventDesc;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;

  Event({
    required this.eventName,
    required this.eventDesc,
    required this.from,
    required this.to,
    this.background = Colors.teal,
    this.isAllDay = false,
  });
}