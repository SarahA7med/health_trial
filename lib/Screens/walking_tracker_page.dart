import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class WalkingTrackerPage extends StatefulWidget {
  final String? userId; // معرف المستخدم

  WalkingTrackerPage({required this.userId});

  @override
  _WalkingTrackerPageState createState() => _WalkingTrackerPageState();
}

class _WalkingTrackerPageState extends State<WalkingTrackerPage> {
  Duration elapsedTime = Duration();
  Timer? timer;
  DateTime? workoutStartTime;

  @override
  void initState() {
    super.initState();
    startWorkoutSession(); // بدء تتبع الوقت
  }

  // دالة لبدء تتبع الجلسة
  void startWorkoutSession() {
    workoutStartTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime = elapsedTime + Duration(seconds: 1);
      });
    });
  }

  // دالة لإنهاء الجلسة وتخزينها في Firestore
  Future<void> endWorkoutSession() async {
    await FirebaseFirestore.instance.collection('workouts').add({
      'user_id': widget.userId, // تخزين معرف المستخدم
      'start_time': workoutStartTime,
      'end_time': DateTime.now(),
      'duration': elapsedTime.inSeconds,
    });

    print("Workout session ended and saved to Firestore");
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // دالة لتنسيق الوقت بصيغة HH:MM:SS
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF759EFF), // استخدم الديكور هنا
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Time Elapsed: ${formatTime(elapsedTime)}',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await endWorkoutSession();
                  Navigator.pop(context);
                },
                child: Text('Stop and Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
