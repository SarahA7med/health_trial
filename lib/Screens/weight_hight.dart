import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home_State.dart';

class WeightHight extends StatefulWidget {
  final String name;
  final String email;
  final String gender;
  final String profilePicture;
  final int age;

  const WeightHight({
    super.key,
    required this.gender,
    required this.profilePicture,
    required this.age,
    required this.name,
    required this.email
  });

  @override
  State<WeightHight> createState() => _WeightHightState();
}

class _WeightHightState extends State<WeightHight> {
  double hightVal = 160;
  double weightval = 70;

  Future<void> uploadUserData({
    required String name,
    required String email,
    required String gender,
    required String profilePicture,
    required int age,
    required double height,
    required double weight,
    required String token, // New token parameter
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users.add({
        'name':name,
        'email':email,
        'gender': gender,
        'profilePicture': profilePicture,
        'age': age,
        'height': height,
        'weight': weight,
        'token': token, // Include token in the uploaded data
      });
      print('Data uploaded successfully');
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "What's your height?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Slider(
              value: hightVal,
              min: 100,
              max: 220,
              divisions: 120,
              label: hightVal.round().toString(),
              onChanged: (double value) {
                setState(() {
                  hightVal = value;
                });
              },
            ),
            Text(
              "${hightVal.round()} cm",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 50),
            const Text(
              "What's your weight?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Slider(
              value: weightval,
              min: 30,
              max: 200,
              divisions: 170,
              label: weightval.round().toString(),
              onChanged: (double value) {
                setState(() {
                  weightval = value;
                });
              },
            ),
            Text(
              "${weightval.round()} kg",
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                String? token = await FirebaseAuth.instance.currentUser?.getIdToken(); // استخدام await هنا
                if (token != null) {
                  await uploadUserData(
                    name: widget.name,
                    email: widget.email,
                    gender: widget.gender,
                    profilePicture: widget.profilePicture,
                    age: widget.age,
                    height: hightVal,
                    weight: weightval,
                    token: token, // Pass the token
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else {
                  // Handle case where the token is null (e.g., user not logged in)
                  print('User is not logged in. Cannot retrieve token.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff004DFF),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
