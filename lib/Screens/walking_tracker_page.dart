import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sensors_plus/sensors_plus.dart';

class WalkingTrackerPage extends StatefulWidget {
  final String? userId;

  WalkingTrackerPage({required this.userId});

  @override
  _WalkingTrackerPageState createState() => _WalkingTrackerPageState();
}

class _WalkingTrackerPageState extends State<WalkingTrackerPage> {
  Duration elapsedTime = Duration();
  Timer? timer;
  DateTime? workoutStartTime;

  // Step counter variables
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  int steps = 0;
  double previousDistance = 0.0;
  double caloriesBurned = 0.0;

  // Constants for calorie calculation
  final double MET = 3.5; // MET value for walking
  double userWeight = 70.0;

  @override
  void initState() {
    super.initState();
    startWorkoutSession();
    startStepTracking();
    fetchUserWeight();
  }

  // Function to start the workout session and timer
  void startWorkoutSession() {
    workoutStartTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          elapsedTime = elapsedTime + Duration(seconds: 1);
        });
      }
    });
  }

  // Function to track steps using accelerometer
  void startStepTracking() {
    SensorsPlatform.instance.accelerometerEvents.listen((event) {
      if (mounted) {
        setState(() {
          x = event.x;
          y = event.y;
          z = event.z;
          double distance = calculateStepDistance(x, y, z);
          if (distance > 7) {
            steps++;
          }
        });
      }
    });
  }

  // Function to calculate the step distance based on accelerometer data
  double calculateStepDistance(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    double modDistance = magnitude - previousDistance;
    previousDistance = magnitude;
    return modDistance;
  }

  // Fetch user weight from Firestore using userId
  Future<void> fetchUserWeight() async {
    if (widget.userId != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
      if (userDoc.exists) {
        if (mounted) {
          setState(() {
            userWeight = (userDoc['weight'] ?? 70.0) as double; // جلب الوزن من الفايرستور، إذا لم يكن موجودًا يتم تعيين الوزن الافتراضي 70 كجم
          });
        }
      }
    }
  }

  // Function to calculate the calories burned
  void calculateCaloriesBurned() {
    double durationInHours = elapsedTime.inSeconds / 3600;
    caloriesBurned = (MET * userWeight * durationInHours);
  }

  // Function to end the workout session and save it to Firestore
  Future<void> endWorkoutSession() async {
    calculateCaloriesBurned();

    await FirebaseFirestore.instance.collection('workouts').add({
      'user_id': widget.userId,
      'start_time': workoutStartTime,
      'end_time': DateTime.now(),
      'duration': elapsedTime.inSeconds,
      'calories_burned': caloriesBurned,
    });

    print("Workout session ended and saved to Firestore with $caloriesBurned calories burned.");
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Function to format the time in HH:MM:SS
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Track Walking'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Image.asset('assets/walking.gif'), // صورة تحرك
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBE4FF),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.timer),
                          const SizedBox(height: 5),
                          const Text(
                            'Time Elapsed',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            formatTime(elapsedTime),
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF759EFF),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.directions_walk, color: Colors.white),
                          const Text(
                            'Steps',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$steps',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),ElevatedButton(
                onPressed: () async {
                  await endWorkoutSession();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004DFF),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Stop and Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
