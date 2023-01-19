import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Edit"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.clear)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.save)),
        ],
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
