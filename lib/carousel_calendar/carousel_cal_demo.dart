import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class CarouselApp extends StatelessWidget {
  const CarouselApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dooboolab flutter calendar',
      theme:  ThemeData(
        primarySwatch: Colors.red,
      ),
      home:  const CarouselPage(title: 'Flutter Calendar Carousel Example'),
    );
  }
}

class CarouselPage extends StatefulWidget {
  const CarouselPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CarouselPageState createState() =>  _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  DateTime _currentDate = DateTime(2023, 2, 3);
  DateTime _currentDate2 = DateTime(2023, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2023, 2, 3));
  DateTime _targetDateTime = DateTime(2023, 2, 3);
  static final Widget _eventIcon =  Container(
    decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child:  const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  final EventList<Event> _markedDateMap =  EventList<Event>(
    events: {
       DateTime(2023, 2, 10): [
         Event(
          date:  DateTime(2023, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
         Event(
          date:  DateTime(2023, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
         Event(
          date:  DateTime(2023, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
         DateTime(2023, 2, 25),
         Event(
          date:  DateTime(2023, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
         DateTime(2023, 2, 10),
         Event(
          date: new DateTime(2023, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll( DateTime(2023, 2, 11), [
       Event(
        date:  DateTime(2023, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
       Event(
        date:  DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
       Event(
        date:  DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon
    final calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      headerText: 'Custom Header',
      weekFormat: true,
      markedDatesMap: _markedDateMap,
      height: 200,
      selectedDateTime: _currentDate2,
      showIconBehindDayText: true,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 3,
      selectedDayTextStyle: const TextStyle(
        color: Colors.yellow,
      ),
      todayTextStyle: const TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon ?? const Icon(Icons.help_outline);
      },
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.blue,
      markedDateMoreShowTotal: true,
    );

    /// Example Calendar Carousel without header and custom prev & next button
    final calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        setState(() => _currentDate2 = date);
        for (var event in events) {
          print(event.title);
        }
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
      const CircleBorder(side: BorderSide(color: Colors.blue)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.red,
      selectedDayTextStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: calendarCarousel,
              ), // This trailing comma makes auto-formatting nicer for build methods.

              Container(
                margin: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          _currentMonth,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )),
                    TextButton(
                      child: const Text('PREV'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: calendarCarouselNoHeader,
              ), //
            ],
          ),
        ));
  }
}