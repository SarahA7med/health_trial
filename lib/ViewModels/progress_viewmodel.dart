import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/Repository/progress_repo.dart';
import '../Models/goals_model.dart';
import '../Models/progressmodel.dart';
import '../Models/water_progress.dart';

class ProgressViewModel extends ChangeNotifier {
 String? userId;
 double? waterGoalsDaily;
 int?  caloriesGoalDaily;
 int? exerciseDurationGoalDaily;
 List<GoalsModel> _weeklyGoals = [];
 List<GoalsModel> get weeklyGoals => _weeklyGoals;
 double _totalWeeklyWaterGoals = 0;
 double get totalWeeklyWaterGoals => _totalWeeklyWaterGoals;
 int _totalWeeklyExerciseDuration = 0;
 int get totalWeeklyExerciseDuration => _totalWeeklyExerciseDuration;
 List<GoalsModel> _monthlyGoals = [];
 List<GoalsModel> get monthlyGoals => _monthlyGoals;
 double _totalMonthlyWaterGoals = 0;
 double get totalMonthlyWaterGoals => _totalMonthlyWaterGoals;
 int _totalMonthlyExerciseDuration = 0;
 int get totalMonthlyExerciseDuration => _totalMonthlyExerciseDuration;

 List<GoalsModel> _yearlyGoals = [];
 List<GoalsModel> get yearlyGoals => _yearlyGoals;
 double _totalYearlyWaterGoals = 0;
 double get totalYearlyWaterGoals => _totalYearlyWaterGoals;

 int _totalYearlyExerciseDuration = 0;
 int get totalYearlyExerciseDuration => _totalYearlyExerciseDuration;

 final ProgressRepo _repository = ProgressRepo();
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
  Future<void> fetchUserGoalsDaily() async {
    await fetchUserId();
    if (userId != null) {
      GoalsModel? goals = await _repository.getUserGoalsDaily(userId!);
      print('data complete');
      if (goals != null) {
       waterGoalsDaily = goals.waterGoal;
       caloriesGoalDaily = goals.caloriesGoal;
        exerciseDurationGoalDaily = goals.exerciseDurationGoal;
        notifyListeners();
      } else {
        print('empty data/usergoals');
      }
    } else {
      print('userid null/getgoals');
    }
  }
 Future<void> fetchWeeklyGoals(String userId) async {
   _weeklyGoals = await _repository.getWeeklyGoals(userId);
   _totalWeeklyWaterGoals = _weeklyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
   _totalWeeklyExerciseDuration = _weeklyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);

   notifyListeners();
 }
 Future<void> fetchMonthlyGoals(String userId) async {
   _monthlyGoals = await _repository.getMonthlyGoals(userId);


   _totalMonthlyWaterGoals = _monthlyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
   _totalMonthlyExerciseDuration = _monthlyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);

   notifyListeners();
 }
 Future<void> fetchYearlyGoals(String userId) async {
   _yearlyGoals = await _repository.getYearlyGoals(userId);


   _totalYearlyWaterGoals = _yearlyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
   _totalYearlyExerciseDuration = _yearlyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);

   notifyListeners();
 }
}


