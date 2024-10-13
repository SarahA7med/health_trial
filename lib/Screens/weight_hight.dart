import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../UserData.dart';
import 'Home_State.dart';

class WeightHight extends StatefulWidget {
  const WeightHight({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WeightHightState();
  }
}

class _WeightHightState extends State<WeightHight> {
  double hightVal = 95,
      weightval = 60;
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Select Your Height",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Slider(
                            value: hightVal,
                            min: 40,
                            max: 250,
                            activeColor: const Color(0xFF004DFF),
                            inactiveColor: const Color(0xFFDBE4FF),
                            onChanged: (val) {
                              setState(() {
                                hightVal = val;
                                userData.height = hightVal;
                              });
                            }),
                        Text(
                          '${hightVal.toInt()} cm',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          "Select Your Weight",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: AnimatedWeightPicker(
                              min: 40,
                              max: 180,
                              suffixTextColor: Colors.black,
                              dialColor: const Color(0xFF004DFF),
                              selectedValueColor: Colors.black,
                              majorIntervalColor: const Color(0xFF004DFF),
                              subIntervalColor: const Color(0xFF759EFF),
                              dialThickness: 2,
                              onChange: (newValue) {
                                setState(() {
                                  weightval = double.parse(newValue);
                                  userData.weight = weightval;
                                });
                              },
                            )),
                        const SizedBox(height: 150),
                        ElevatedButton(
                          onPressed: () {
                            _uploadUserData();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _uploadUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .add({
    'userName': userData.name,
    'weight': userData.weight,
    'height': userData.height,
    'gender': userData.gender,
    'age': userData.age,
    'id':FirebaseAuth.instance.currentUser?.uid
    })
        .then((value) => print("user added"))
        .catchError((e) => print("failed to add user:$e"));
  }
}
