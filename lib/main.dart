import 'package:calender/calender_list.dart';
import 'package:calender/syncfusion_calender/syncfusion_cal.dart';
import 'package:calender/table_calender/table_event_calender.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'table_calender/event_cal.dart';

void main() {
  initializeDateFormatting().then((_) {

  runApp(const MyApp());
  } );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: CalenderList(),
    );
  }
}


