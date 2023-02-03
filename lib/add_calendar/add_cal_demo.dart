import 'package:flutter/material.dart';

import 'package:add_2_calendar/add_2_calendar.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: 'Test eventeee',
      description: 'example',
      location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://example.com",
      ),
      androidParams: const AndroidParams(
        emailInvites: ["test@example.com"],
      ),
      recurrence: recurrence,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){}),
          title: const Text('Add event to calendar example'),
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: const Text('Add normal event'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () {
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Add event with recurrence 1'),
              subtitle: const Text("weekly for 3 months"),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                Add2Calendar.addEvent2Cal(buildEvent(
                  recurrence: Recurrence(
                    frequency: Frequency.weekly,
                    endDate: DateTime.now().add(Duration(days: 60)),
                  ),
                ));
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Add event with recurrence 2'),
              subtitle: const Text("every 2 months for 6 times (1 year)"),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                Add2Calendar.addEvent2Cal(buildEvent(
                  recurrence: Recurrence(
                    frequency: Frequency.monthly,
                    interval: 2,
                    ocurrences: 6,
                  ),
                ));
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Add event with recurrence 3'),
              subtitle:
              const Text("RRULE (android only) every year for 10 years"),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                Add2Calendar.addEvent2Cal(buildEvent(
                  recurrence: Recurrence(
                    frequency: Frequency.yearly,
                    rRule: 'FREQ=YEARLY;COUNT=10;WKST=SU',
                  ),
                ));
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

/*cell calendar*/
// import 'package:cell_calendar/cell_calendar.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'cell_calendar example'),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     final _sampleEvents = sampleEvents();
//     final cellCalendarPageController = CellCalendarPageController();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: CellCalendar(
//         cellCalendarPageController: cellCalendarPageController,
//         events: _sampleEvents,
//         daysOfTheWeekBuilder: (dayIndex) {
//           final labels = ["S", "M", "T", "W", "T", "F", "S"];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 4.0),
//             child: Text(
//               labels[dayIndex],
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           );
//         },
//         monthYearLabelBuilder: (datetime) {
//           final year = datetime?.year.toString();
//           final month = datetime?.month.monthName;
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             child: Row(
//               children: [
//                 const SizedBox(width: 16),
//                 Text(
//                   "$month  $year",
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   padding: EdgeInsets.zero,
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () {
//                     cellCalendarPageController.animateToDate(
//                       DateTime.now(),
//                       curve: Curves.linear,
//                       duration: Duration(milliseconds: 300),
//                     );
//                   },
//                 )
//               ],
//             ),
//           );
//         },
//         onCellTapped: (date) {
//           final eventsOnTheDate = _sampleEvents.where((event) {
//             final eventDate = event.eventDate;
//             return eventDate.year == date.year &&
//                 eventDate.month == date.month &&
//                 eventDate.day == date.day;
//           }).toList();
//           showDialog(
//               context: context,
//               builder: (_) => AlertDialog(
//                 title:
//                 Text(date.month.monthName + " " + date.day.toString()),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: eventsOnTheDate
//                       .map(
//                         (event) => Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(4),
//                       margin: EdgeInsets.only(bottom: 12),
//                       color: event.eventBackgroundColor,
//                       child: Text(
//                         event.eventName,
//                         style: TextStyle(color: event.eventTextColor),
//                       ),
//                     ),
//                   )
//                       .toList(),
//                 ),
//               ));
//         },
//         onPageChanged: (firstDate, lastDate) {
//           /// Called when the page was changed
//           /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
//         },
//       ),
//     );
//   }
// }