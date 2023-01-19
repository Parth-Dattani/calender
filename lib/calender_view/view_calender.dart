import 'package:flutter/material.dart';

class ViewCalender extends StatefulWidget {
  const ViewCalender({Key? key}) : super(key: key);

  @override
  State<ViewCalender> createState() => _ViewCalenderState();
}

class _ViewCalenderState extends State<ViewCalender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calender View"),
      ),
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
