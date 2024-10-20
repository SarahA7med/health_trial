import 'package:flutter/material.dart';
import 'package:health_trial/Repository/goals_repo.dart';
import 'package:health_trial/Models/user_model.dart';
import 'package:health_trial/Models/goals_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserViewModel extends ChangeNotifier {
  final Repository _repository = Repository();
  String? userId;
  String? userName;
  double? userWeight;
  double? waterGoal;
  int? caloriesGoal;
  int? exerciseDurationGoal;

  UserViewModel() {
    fetchUserId();
    fetchUserData();
  }

  // user id
  Future<void> fetchUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      print('User ID: $userId');
    } else {
      print('No user ID found');
    }
    notifyListeners();
  }

  // userdata from repo
  Future<void> fetchUserData() async {
    await fetchUserId();

    if (userId != null) {
      Users? user = await _repository.getUserData(userId!);
      if (user != null) {
        userName = user.name;
        userWeight = user.weight;
        notifyListeners();
        print("get user name $userName"); // update data
      }

      await fetchUserGoals();
      notifyListeners();
    } else {
      print("User ID is null, cannot fetch user data.");
    }
  }



  // save goals
  Future<void> saveUserGoals(double waterGoal, int caloriesGoal, int exerciseDurationGoal, BuildContext context) async {
    if (userId != null) {
     try {


        await _repository.saveUserGoals(userId!,waterGoal, caloriesGoal,  exerciseDurationGoal);
        await fetchUserGoals();
notifyListeners();
        // عرض SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Goals saved successfully'),
            duration: Duration(seconds: 2),
          ),
        );

        print("Goals saved successfully");
      } catch (e) {
        print("Error saving goals: $e");
      }
    } else {
      print("User ID is null, cannot save goals.");
    }
  }
  // goals from repo
  Future<void> fetchUserGoals() async {
    await fetchUserId();
    if (userId != null) {
      GoalsModel? goals = await _repository.getUserGoals(userId!);
      print('data complete');
      if (goals != null) {
        waterGoal = goals.waterGoal;
        caloriesGoal = goals.caloriesGoal;
        exerciseDurationGoal = goals.exerciseDurationGoal;
        notifyListeners();
      } else {
        print('empty data/usergoals');
      }
    } else {
      print('userid null/getgoals');
    }
  }
}