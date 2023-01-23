
import 'dart:math';

import 'package:calender/utils.dart';
import 'package:flutter/material.dart';

class AddEventPage2 extends StatefulWidget {
  final Event? event;
  const AddEventPage2({Key? key, this.event}) : super(key: key);

  @override
  State<AddEventPage2> createState() => _AddEventPage2State();
}

class _AddEventPage2State extends State<AddEventPage2> {
  late DateTime fromDate;
  late DateTime toDate;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();


  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Edit"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.clear)),
          IconButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              print(titleController.text);
              print(descController.text);
              print(toDate);
            }
            else {
              print("not");
            }
          }, icon: const Icon(Icons.save)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'enter title'
                    ),
                    onFieldSubmitted: (_) {},
                    validator: (title) {
                      if (title == null || title.isEmpty) {
                        return "title cannot Empty";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'enter description'
                    ),
                    onFieldSubmitted: (_) {},
                    validator: (desc) {
                      if (desc == null || desc.isEmpty) {
                        return "description cannot be Empty";
                      }
                      else {
                        null;
                      }
                    },
                  ),

                  const SizedBox(height: 20,),
                  const Text("from date Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: dropDown(text: Utils.toDate(fromDate),
                              onClick: () {
                            pickFromDateTime(pickDate: true);
                              })),
                      Expanded(child: dropDown(text: Utils.toTime(fromDate),
                          onClick: () {
                        pickFromDateTime(pickDate: false);
                          }))
                    ],
                  ),

                  const SizedBox(height: 10,),
                  Text("to date Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: dropDown(text: Utils.toDate(toDate),
                              onClick: () {
                                pickFromDateTime(pickDate: true);
                              })),
                      Expanded(child: dropDown(text: Utils.toTime(toDate),
                          onClick: () {
                        pickFromDateTime(pickDate: true);
                        print(toDate);
                          }))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future pickFromDateTime({
    required bool pickDate
  }) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if(date == null) return ;
    setState(() {
      date;
      print("change date ${date}");
    });
  }

  Future<DateTime?> pickDateTime(
      DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate?? DateTime(2022,12),
          lastDate: DateTime(2024));

      if(date == null)
        {
          //return null;
          print("ssss:${date}");
        }
      else {
        //print("date: ${date}");
        final timeOfDay = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(initialDate));

        if (timeOfDay == null) return null;
        final date = DateTime(
            initialDate.hour, initialDate.minute, initialDate.second);


        final time = Duration(
            hours: timeOfDay.hour,
            minutes: timeOfDay.minute,
        );

        return date.add(time);
      }
    }
  }

  Widget dropDown({
    required String text,
    required VoidCallback onClick,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClick,
      );


}