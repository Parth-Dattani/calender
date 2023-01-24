import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media_signin/flutter_social_media_signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../model/user_model.dart';
import '../widget/CalenderClient.dart';
import '../widget/google_login.dart';
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
  User? user2;
  final GoogleSignIn googleSignIn2 = GoogleSignIn();


  @override
  void initState() {
    super.initState();
   // signInwithGoogle();
    _selectedDate = _focusDay;
    // googleSignIn.onCurrentUserChanged.listen((event) {
    //   setState(() {
    //     user = event;
    //   });
    // });
    //googleSignIn.signInSilently();
  }




  //Library through Login
  Future<void> signInwithGoogle() async {
    print("Google Auth Before");
    var googleAuth = await FlutterSocialMediaSignin().signInWithGoogle();
    print("Google Auth $googleAuth");
    await auth.signInWithCredential(googleAuth).whenComplete(() =>
        sendDataFirestore(auth.currentUser!.displayName.toString(),
            auth.currentUser!.email.toString()));
    print("success");
    print("authf ${auth}");
    //await Get.toNamed(HomeScreen.pageId);
  }

  sendDataFirestore(String userName, String email) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.userName = userName;
    userModel.email = email;
    userModel.uid = user!.uid;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      googleAPI.CalendarApi.calendarScope
    ],
  );


  Future<void> signInGoogle()async{
    try{
      await googleSignIn.signIn();
    }catch(e){
      print("error $e");
    }
  }

  //GoogleSignInAccount? user;


  CalendarController calendarController = CalendarController();
  CalendarView calenderView = CalendarView.week;

  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        elevation: 1,
        actions: [
          IconButton(onPressed: () {
            //editEvent(0);
            //signInGoogle();
            // Authentication.signInWithGoogle(/*context: context*/);
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
                                await calendarClient.insert(
                                  titleController.text,
                                  startTime,
                                  endTime,
                                );
                                setState(() {
                                  // _selectedDate = _focusDay;
                                  // _selectedDate = _focusDay;
                                  print("calleed");

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
                                  print(
                                      "Event Added ${json.encode(mySelectedEvent)}");
                                  titleController.clear();
                                  descriptionController.clear();
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Text("Add Event")),
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
          Colors.purple, false),
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
