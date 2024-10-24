import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/ViewModels/goals_viewmodel.dart';
import 'package:health_trial/ViewModels/progress_viewmodel.dart';
import 'package:provider/provider.dart';

import 'AppStartScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserViewModel()..fetchUserGoals()),
        ChangeNotifierProvider(create: (_) => ProgressViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Appstartscreen(),
    );
  }


}
