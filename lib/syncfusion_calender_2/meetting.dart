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