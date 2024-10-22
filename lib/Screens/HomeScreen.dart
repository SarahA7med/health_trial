import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModels/goals_viewmodel.dart';




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
          title: const Text('Fitness Tracker',style:TextStyle(color: Colors.white),),
          backgroundColor: const Color(0xFF004DFF),
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
                                const Image(
                                  image: AssetImage("assets/waving-hand.png"),
                                  height: 50,
                                  width: 50,
                                ),
                                Text(
                                  "Hello  ${viewModel.userName ?? ' '}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Set Your Goals",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

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
                        const Text(
                          "Your Goals:",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Water Goal: ${viewModel.waterGoal ?? 'Not Set'} liters"),
                        Text("Calories Goal: ${viewModel.caloriesGoal ?? 'Not Set'} calories"),
                        Text("Exercise Duration Goal: ${viewModel.exerciseDurationGoal ?? 'Not Set'} minutes"),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),

                // Water Intake Field
                Card(
                  color: const Color(0xffB1c8ff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 30,top: 30),
                    child: TextFormField(
                      controller: waterController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: "Water Intake (in liters)",
                        hintText: "Enter amount of water (liter)",
                        suffixIcon: Icon(Icons.local_drink),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Calories Intake Field
                Card(
                  color: const Color(0xff759eff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 30,top: 30),                    child: TextFormField(
                      controller: caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Calories burned",
                        hintText: "Enter calories (e.g. 2000)",
                        suffixIcon: Icon(Icons.fastfood),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Exercise Duration Field
                Card(
                  color: const Color(0xffDbe4ff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 30,top: 30),
                    child: TextFormField(
                      controller: exerciseDurationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Exercise Duration (in minutes)",
                        hintText: "Enter duration (e.g. 30)",
                        suffixIcon: Icon(Icons.fitness_center),
                      ),
                    ),
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
                        const SnackBar(
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
                        const SnackBar(
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
                        const SnackBar(
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
                    backgroundColor: const Color(0xFF004DFF),

                  ),
                  child: const Text('Save Goals', style: TextStyle(color: Colors.white)),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}