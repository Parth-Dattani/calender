import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class TableEventCalender extends StatefulWidget {
  const TableEventCalender({Key? key}) : super(key: key);

  @override
  State<TableEventCalender> createState() => _TableEventCalenderState();
}

class _TableEventCalenderState extends State<TableEventCalender> {

  CalendarFormat _calendarFormat  = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime? _selectedDate;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

    Map<String, List> mySelectedEvent = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusDay;
    //loadPrevEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Event Calender"),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                locale: 'en_US',
                  focusedDay: _focusDay,
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2024),
                calendarFormat:_calendarFormat,

                startingDayOfWeek: StartingDayOfWeek.monday,
                rowHeight: 50,
                daysOfWeekHeight: 50,
                headerStyle: const HeaderStyle(
                  titleTextStyle:  TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                    formatButtonTextStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
                    formatButtonDecoration:
                    BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(strokeAlign: StrokeAlign.center,width: 3,color: Colors.indigoAccent),
                      // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  leftChevronIcon: Icon(Icons.arrow_back_ios,
                  color: Colors.black,
                  ),
                  rightChevronIcon: Icon(Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),

                ),



                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: Colors.red
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(
                    color: Colors.red
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.cyan,
                    shape: BoxShape.circle
                  ),
                  selectedDecoration:  BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle
                  ),
                ),



                onDaySelected: (selectDay, focusDay){
                    if(!isSameDay(_selectedDate, selectDay)){
                      setState(() {
                        _selectedDate = selectDay;
                        _focusDay = focusDay;
                      });
                    }
                },

                selectedDayPredicate: (day){
                    return isSameDay(_selectedDate, day);
                },

                onFormatChanged: (formate){
                    if(_calendarFormat != formate){
                      setState(() {
                        _calendarFormat = formate;
                      });
                    }
                },

                onPageChanged: (focusDay){
                    _focusDay = focusDay;
                },

                eventLoader: listOfEvents,
              ),

              ...listOfEvents(_selectedDate!).map((e) =>
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
          leading: const Icon(Icons.done, color: Colors.red,),
          title: Text("Event Title : ${e['eventTitle']}"),
          subtitle: Text("Event Description : ${e['eventDescription']}"),
      ),
                  ))

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _showAddEventDialog,
          label: const Text("Add Event")
      ),
    );
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add Event",textAlign: TextAlign.center),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: "Title"
                ),
              ),
              TextField(
                controller: descriptionController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                    labelText: "Description"
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),

            TextButton(onPressed: (){
              if(titleController.text.isEmpty &&
                  descriptionController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("please enter title & description"),
                  duration: Duration(seconds: 3),
                  )
                );
                return ;
              }
              else{
                print("object ${titleController.text}");

                setState(() {
                  if(mySelectedEvent[DateFormat('yyyy-MM-dd')
                      .format(_selectedDate!)]
                  != null){

                    mySelectedEvent[DateFormat('yyyy-MM-dd')
                        .format(_selectedDate!)]?.add(
                      {
                        "eventTitle": titleController.text,
                        "eventDescription": descriptionController.text,
                      });
                  }

                  else{
                    mySelectedEvent[DateFormat('yyyy-MM-dd')
                      .format(_selectedDate!)] = [{
                  "eventTitle": titleController.text,
                  "eventDescription": descriptionController.text,
                  }];
                  }
                  print("Event Added ${json.encode(mySelectedEvent)}");
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                });
              }
            }, child: const Text("Add Event")),
          ],
        ),
    );
  }

  List listOfEvents(DateTime dateTime){
    if(mySelectedEvent[DateFormat('yyyy-MM-dd').format(dateTime)]!=null){
     return mySelectedEvent[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    }
    else{
      return[];
    }
  }

  // List<Event> _getEventsForDay(DateTime day) {
  //   return events[day] ?? [];
  // }
  //
  // final events = LinkedHashMap(
  //   equals: isSameDay,
  //   hashCode: getHashCode,
  // )..addAll(my);

  /*loadPrevEvents() {
    mySelectedEvent = {
      "2023-01-13": [
        {"eventTitle": "11", "eventDescription": "111"},
        {"eventTitle": "22", "eventDescription": "22"}
      ],
      "2023-01-30": [
        {"eventTitle": "Task 22", "eventDescription": "2dsfasdf2"}
      ],
      "2023-01-20": [
        {"eventTitle": "ss", "eventDescription": "ss"}
      ]
    };
  }*/
}
