import 'package:calender/calender_view/view_calender.dart';
import 'package:calender/syncfusion_calender/syncfusion_cal.dart';
import 'package:calender/table_calender/table_event_calender.dart';
import 'package:flutter/material.dart';

class CalenderList extends StatefulWidget {
  const CalenderList({Key? key}) : super(key: key);

  @override
  State<CalenderList> createState() => _CalenderListState();
}

class _CalenderListState extends State<CalenderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calender's")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
style: TextButton.styleFrom(
  fixedSize: Size.fromWidth(200),
  minimumSize: Size(140, 40),
  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
),
                  onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TableEventCalender(),));
              }, child: Text("Table Event")),
              TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size.fromWidth(200),
                    minimumSize: const Size(140, 40),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  onPressed: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewCalender(),));
              }, child: const Text("Calender-View")),

              TextButton(
                  style: TextButton.styleFrom(
                      fixedSize: Size.fromWidth(200),
                      minimumSize: Size(140, 40),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  onPressed: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                     const SyncfusionCal(),));
                  }, child: const Text("Synfusion Calender"))
            ],
          ),
        ),
      ),
    );
  }
}
