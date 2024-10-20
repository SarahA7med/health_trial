import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModels/goals_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homescreen extends StatelessWidget {
  final TextEditingController waterController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController exerciseDurationController = TextEditingController();
  // final FirebaseFirestore fir = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel()..fetchUserData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fitness Tracker',style:TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFF004DFF),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                // Greeting Section
                Consumer<UserViewModel>(
                  builder: (context, viewModel, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/waving-hand.png"),
                                  height: 50,
                                  width: 50,
                                ),
                                Text(
                                  "Hello  ${viewModel.userName ?? ' '}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Set Your Goals",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.add_alert_sharp, size: 30, color: Colors.grey),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                // show goals
                Consumer<UserViewModel>(
                  builder: (context, viewModel, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Goals:",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Water Goal: ${viewModel.waterGoal ?? 'Not Set'} liters"),
                        Text("Calories Goal: ${viewModel.caloriesGoal ?? 'Not Set'} calories"),
                        Text("Exercise Duration Goal: ${viewModel.exerciseDurationGoal ?? 'Not Set'} minutes"),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),

                // Water Intake Field
                TextFormField(
                  controller: waterController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: "Water Intake (in liters)",
                    hintText: "Enter amount of water (liter)",
                    suffixIcon: Icon(Icons.local_drink),
                  ),
                ),
                const SizedBox(height: 20),

                // Calories Intake Field
                TextFormField(
                  controller: caloriesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Calories Intake",
                    hintText: "Enter calories (e.g. 2000)",
                    suffixIcon: Icon(Icons.fastfood),
                  ),
                ),
                const SizedBox(height: 20),

                // Exercise Duration Field
                TextFormField(
                  controller: exerciseDurationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Exercise Duration (in minutes)",
                    hintText: "Enter duration (e.g. 30)",
                    suffixIcon: Icon(Icons.fitness_center),
                  ),
                ),
                const SizedBox(height: 20),

                // save goals button
                ElevatedButton(
                  onPressed: () async {

                    String waterInput = waterController.text;
                    String caloriesInput = caloriesController.text;
                    String durationInput = exerciseDurationController.text;

                    // validation water positive and from 1 to 7 liter
                    double? waterGoal = double.tryParse(waterInput);
                    if (waterGoal == null || waterGoal < 1.0 || waterGoal > 7.0||waterGoal<0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid water input. Must be between 1 and 7 liters."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      print("Invalid water input. Must be between 1 and 7 liters .");
                      return;
                    }

                    // validation calories positive and not null
                    int? caloriesGoal = int.tryParse(caloriesInput);
                    if (caloriesGoal == null || caloriesGoal <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid colories input. Must be  positive and not null ."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      print("Invalid calories input. Must be a positive number.");
                      return;
                    }


                    int? exerciseDurationGoal = int.tryParse(durationInput);
                    if (exerciseDurationGoal == null || exerciseDurationGoal < 10 || exerciseDurationGoal > 120) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid water input. Must be between 10 and 120 minutes."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      print("Invalid exercise duration. Must be between 10 and 120 minutes.");
                      return;
                    }

                    // invoke savegoals method
                    await Provider.of<UserViewModel>(context, listen: false)
                        .saveUserGoals(waterGoal, caloriesGoal, exerciseDurationGoal,context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004DFF),
                  ),
                  child: Text('Save Goals', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}