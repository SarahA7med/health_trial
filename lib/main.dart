import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/Screens/on_boarding_screen.dart';
 import 'package:flutter/material.dart';
import 'package:health_trial/ViewModels/goals_viewmodel.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>UserViewModel()),
        //  ChangeNotifierProvider(create: (_) => SecondViewModel()),
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:OnBoardingScreen(),
    );
  }
}

