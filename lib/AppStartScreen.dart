import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Screens/Home_State.dart';
import 'Screens/dash_board.dart';
import 'Screens/on_boarding_screen.dart';

class Appstartscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check the current user state
    User? user = FirebaseAuth.instance.currentUser;

    // If the user is logged in, go to the home screen, otherwise go to the auth screen
    if (user != null) {
      return HomePage(); // Redirect to the home screen if logged in
    } else {
      return OnBoardingScreen(); // Redirect to the On Boarding screen if not logged in
    }
  }
}
