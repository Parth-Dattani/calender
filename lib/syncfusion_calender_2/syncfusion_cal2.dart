import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../model/event_model.dart';
import '../widget/CalenderClient.dart';
import '../widget/google_login.dart';
import '../widget/remot_services.dart';
import 'meeting_data_source2.dart';
import 'meetting2.dart';

class SyncfusionCal2 extends StatefulWidget {
  const SyncfusionCal2({Key? key}) : super(key: key);

  @override
  State<SyncfusionCal2> createState() => _SyncfusionCal2State();
}

class _SyncfusionCal2State extends State<SyncfusionCal2> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Map<String, List> mySelectedEvent = {};
  final DateTime _focusDay = DateTime.now();
  DateTime? _selectedDate;
  List<Meeting2> meet = <Meeting2>[];
  List<Meeting2> meetings = <Meeting2>[];
  final auth = FirebaseAuth.instance;
  SharedPreferences? pref;
  List<EventModel> eventList  = <EventModel>[];

  @override
  void initState() {
    super.initState();

    _selectedDate = _focusDay;
    //initPref();
  }

  initPref() async{
    pref = await SharedPreferences.getInstance();
    setState((){
      mySelectedEvent = Map<String, List>.from(
          json.decode(pref!.getString("eventTitle").toString()));
    });
  }

  CalendarController calendarController = CalendarController();
  CalendarView calenderView = CalendarView.week;

  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(hours: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        elevation: 1,
        actions: [
          IconButton(onPressed: () async {
            //editEvent(0);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    "Event getting"),
              ),
            );

            try{
              var response = await RemoteServices.getData();

              if(response.statusCode == 200){
                print("cal Data featch");
                var jsonData = json.decode(response.body);
                print("json data:${jsonData}");
                eventList = EventModel.fromJson(jsonData) as List<EventModel>;
                print("evetnt:$eventList");
                titleController.text = eventList.first.summary!;
                print("Summary : ${titleController.text = eventList.first.items![0].summary.toString()}");

                for(var i=0; i<=response.body.length; i++){
                  print("itm1: ${response.body}");
                }
              }
              else{
                print("status not match");
              }
            }
            catch(e){
              print("Ex: $e");
            }
          }, icon: const Icon(Icons.downloading_rounded)),
          IconButton(onPressed: () {
            //editEvent(0);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "user : ${auth.currentUser!.displayName.toString()}"),
              ),
            );
          }, icon: const Icon(Icons.person)),
          IconButton(onPressed: () {
            Authentication.signOut(context: context);
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        print("calender View : ${calenderView}");
                        calenderView = CalendarView.day;
                        calendarController.view = calenderView;
                      });
                    },
                    child: Text("Day")),
                OutlinedButton(
                    onPressed: () {
                      print("calender View : ${calenderView}");
                      setState(() {
                        calenderView = CalendarView.week;
                        calendarController.view = calenderView;
                      });
                    },
                    child: Text("Week")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        print("calender View : ${calenderView}");
                        calenderView = CalendarView.month;
                        calendarController.view = calenderView;
                      });
                    },
                    child: Text("month"))
              ],
            ),
            // SfCalendar(
            //   view: CalendarView.workWeek,
            //   timeSlotViewSettings: const TimeSlotViewSettings(
            //       startHour: 9,
            //       endHour: 20,
            //       nonWorkingDays: <int>[DateTime.sunday, DateTime.saturday]
            //   ),
            // ),
            // Container(color: Colors.amber,height: 10,),
            Expanded(
              child: SfCalendar(
                view: calenderView,
                controller: calendarController,
                initialSelectedDate: DateTime.now(),
                backgroundColor: Colors.black26,
                firstDayOfWeek: 1,
                cellBorderColor: Colors.transparent,
                headerStyle: const CalendarHeaderStyle(
                    backgroundColor: Colors.red,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontSize: 24,
                    )),
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeInterval: Duration(days: 2),
                ),


                onTap: (calendarTapDetails) {
                  print("object : ${_selectedDate}");
                  print("selected Date ${calendarTapDetails.date.toString()}");
                  _selectedDate = calendarTapDetails.date;

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title:
                          const Text("Add Event", textAlign: TextAlign.center),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: titleController,
                            textCapitalization: TextCapitalization.words,
                            decoration:
                                const InputDecoration(labelText: "Title"),
                          ),
                          // TextField(
                          //   controller: descriptionController,
                          //   textCapitalization: TextCapitalization.words,
                          //   decoration: const InputDecoration(
                          //       labelText: "Description"
                          //   ),
                          // ),
                          TextButton(
                              onPressed: () {
                                SfDateRangePicker(
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                  initialSelectedRange: PickerDateRange(
                                      DateTime.now()
                                          .subtract(const Duration(days: 4)),
                                      DateTime.now()
                                          .add(const Duration(days: 3))),
                                );
                              },
                              child: Text("from Date"))
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                        TextButton(
                            onPressed: () async {
                              if (titleController.text.isEmpty &&
                                  descriptionController.text.isEmpty) {
                                print("if ${_selectedDate}");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("please enter title & description"),
                                  duration: Duration(seconds: 3),
                                ));
                                return;
                              } else {
                                print("object ${titleController.text}");
                                print("object else ${_selectedDate}");
                                print("Focus Day ${_focusDay}");

                                try{
                                  var response = await RemoteServices.insertEvent(
                                      "270962746636-n9d01lu8avmkfm5dtbqg45e26fnfkg37.apps.googleusercontent.com",
                                      "AIzaSyCxUCLPiVvNia109eNC4Nd2EYmPogjVxc0",
                                      titleController.text,
                                      startTime,
                                      endTime
                                  );

                                  if(response.statusCode == 200){
                                    print("stat ${response.statusCode}");
                                  }
                                  else{
                                    print("status not match");
                                  }
                                }
                                catch(e){
                                 print("Ex: $e");
                                }


                                /*in Site*/
                                // await calendarClient.insert(
                                //   titleController.text,
                                //   startTime,
                                //   endTime,
                                // );
                                setState(() {
                                  // _selectedDate = _focusDay;
                                  // _selectedDate = _focusDay;

                                  print("callEnd");
                                  print("object2 else : ${_selectedDate}");
                                  if (mySelectedEvent[DateFormat('yyyy-MM-dd')
                                      .format(_selectedDate!)] !=
                                      null) {
//addEvent();
                                    /* mySelectedEvent[DateFormat('yyyy-MM-dd').format(_selectedDate!)]?.add(
                                  // {
                                  //   "eventTitle": titleController.text,
                                  //   "eventDescription": descriptionController.text,
                                  // },
                                Meeting(titleController.text,
                                    DateTime.now().subtract(Duration(hours: 2)),
                                    DateTime.now().subtract(Duration(hours: 3)),
                                    Colors.indigoAccent,
                                    false)

                                  //meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFFB3175B), false));
                              );*/
                                    print("firsr Time new date :");
                                  }
                                  else {
                                    mySelectedEvent[DateFormat('yyyy-MM-dd')
                                        .format(_selectedDate!)] = [
                                      {
                                        "eventTitle": titleController.text,
                                        "eventDescription":
                                            descriptionController.text,
                                      }
                                    ];
                                  }
                                  addEvent();
                                  pref?.setString("eventTitle", json.encode(mySelectedEvent));
                                  print("Event Added ${json.encode(mySelectedEvent)}");
                                  titleController.clear();
                                  descriptionController.clear();
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: const Text("Add Event")),
                      ],
                    ),
                  );
                },

                selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    shape: BoxShape.rectangle),
                // showWeekNumber: true,
                // weekNumberStyle: WeekNumberStyle(
                //   backgroundColor: Colors.green
                // ),
                monthViewSettings: const MonthViewSettings(
                    showTrailingAndLeadingDates: false,
                    showAgenda: true,
                    agendaStyle: AgendaStyle(
                      backgroundColor: Colors.white,
                      appointmentTextStyle: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF0ffcc00)),
                      dateTextStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                      dayTextStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    monthCellStyle: MonthCellStyle(
                      textStyle: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.indicator),
                //dataSource: MeetingDataSource(_getDataSource()),
                dataSource: MeetingDataSource2(meet),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //  meet = [
            //
            //   //Meeting('Conference 12', DateTime.now(), DateTime.now().add(Duration(hours: 2)), const Color(0xFFB3175B), false),
            //   Meeting('Conference 21', DateTime.now(), DateTime.now().add(Duration(hours: 2)), const Color(0xFFB3175B), false)
            // ];
            // if(titleController.text.isEmpty){
            //   s
            // }
            addEvent();
          },
          label: const Text("Add Event")),
    );
  }

  void addEvent() {
    _selectedDate;
    print("select Date :${_selectedDate}");
    meet.add(
      Meeting2(titleController.text,
          _selectedDate!,
          _selectedDate!.add(Duration(hours: 2)),
          Colors.primaries[Random().nextInt(Colors.primaries.length)], false),
    );
  }

  void editEvent(int index){
    meet[index].eventName = "cj $index";
    print("sse : ${meet[index].eventName = "cj $index"}");
  }
}

/*List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFFB3175B), false));
  meetings.add(Meeting('Conference 3', startTime, endTime, const Color(0xFFB3175B), false));
  meetings.add(Meeting('Conference 2', startTime.add(Duration(hours: 4)), endTime.add(Duration(hours: 3)), const Color(0xFFB3175B), false));

  return meetings;
}*/

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source){
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
//
// Meeting _getMeetingData(int index) {
//   final dynamic meeting = appointments![index];
//   late final Meeting meetingData;
//   if (meeting is Meeting) {
//     meetingData = meeting;
//   }
//
//   return meetingData;
// }
// }
//
// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }
