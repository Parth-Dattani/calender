import 'package:calender/syncfusion_calender_2/syncfusion_cal2.dart';
import 'package:flutter/material.dart';

import '../widget/google_login.dart';



class SyncScreen extends StatelessWidget {
  const SyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        elevation: 1,

      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                Authentication.signInWithGoogle();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                    const SyncfusionCal2(),));
              }, child: const Text("sync Data"))

            ],
          ),
        ),
      ),
    );
  }
}
