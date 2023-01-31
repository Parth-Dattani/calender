import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;

import '../syncfusion_calender_2/sync_screen.dart';

class Authentication {
  static Future<User?> signInWithGoogle(/*{required BuildContext context}*/) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    var clientId =  googleSignIn.clientId;
    List<String> scop =  googleSignIn.scopes;

    // scop.add(
    //   googleAPI.CalendarApi.calendarScope,);
    print("client Id : $clientId");
    print("client Id : $scop");


    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      print("acc$credential}");

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print("object $e");
        }
        else if (e.code == 'invalid-credential') {
          print("elesif $e");
        }
      } catch (e) {
        print("catch $e");
      }
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
        await googleSignIn.signOut();
            await FirebaseAuth.instance.signOut();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>
            const SyncScreen(),));
    } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out. Try again.'),
        ),
      );
    }
  }
}
