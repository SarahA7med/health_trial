import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModels/goals_viewmodel.dart'; // التحقق من تعديل المسار الصحيح
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Homescreen extends StatelessWidget {
  //String userId='';

  // يفضل استخدام const عند عدم تغيير المتغير
  final TextEditingController waterController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController exerciseDurationController = TextEditingController();
  final FirebaseFirestore fir = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // الحصول على معرف المستخدم الفعلي
    // String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return ChangeNotifierProvider(
      create: (context) => UserViewModel()..fetchUserData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fitness Tracker'),
          backgroundColor: Color(0xFF004DFF),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
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
                                  "Hello, ${viewModel.userName ?? 'Guest'}",
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

                // عرض الأهداف
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
                    suffixIcon: Icon(Icons.local_drink), // أيقونة الماء
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
                    suffixIcon: Icon(Icons.fastfood), // أيقونة الطعام
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
                    suffixIcon: Icon(Icons.fitness_center), // أيقونة التمارين
                  ),
                ),
                const SizedBox(height: 20),

                // Save Goals Button
                ElevatedButton(
                  onPressed: () async {
                    // يمكن إضافة وظيفة لحفظ الأهداف هنا
                    await Provider.of<UserViewModel>(context, listen: false).fetchUserData();

                    if (waterController.text.isNotEmpty &&
                        caloriesController.text.isNotEmpty &&
                        exerciseDurationController.text.isNotEmpty) {

                      double waterGoal = double.tryParse(waterController.text) ?? 0.0;
                      int caloriesGoal = int.tryParse(caloriesController.text) ?? 0;
                      int exerciseDurationGoal = int.tryParse(exerciseDurationController.text) ?? 0;

                      // استدعاء ViewModel لحفظ الأهداف
                      await Provider.of<UserViewModel>(context, listen: false)
                          .saveUserGoals(waterGoal, caloriesGoal, exerciseDurationGoal);
                    } else {
                      print("Please fill in all fields before saving.");
                    }
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