import 'package:calender/syncfusion_calender/meetting.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  final Event? event;
  const AddEventPage({Key? key, this.event}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late DateTime fromDate;
  late DateTime toDate;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();


  @override
  void initState() {
    super.initState();

    if(widget.event == null){
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
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.clear)),
          IconButton(onPressed: (){
            if(_formKey.currentState!.validate()){
            }
            else{
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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'enter title'
                    ),
                    onFieldSubmitted: (_){
                    },
                    validator: (title){
                       title!.isEmpty ? "title cannot Empty" : null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'enter description'
                    ),
                    onFieldSubmitted: (_){},
                    validator: (desc){
                      desc != null && desc.isEmpty ? "description cannot be Empty" : null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
