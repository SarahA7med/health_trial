import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/Repository/progress_repo.dart';
import '../Models/goals_model.dart';
import '../Models/progressmodel.dart';
import '../Models/water_progress.dart';

class ProgressViewModel  {
  double? watergoal;
  String? userId;
  int? caloriesGoal;
  int? durationgoal;
  double? progress;  // Progress value (0 to 1)
  int? durationwork; // Actual workout duration
  int? amount;       // Actual water intake amount
double? watergoalsml;
  final ProgressRepo _repository = ProgressRepo();

  Future<void> fetchUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      print('User ID: $userId');
      await fetchUserGoals();
      await fetchUserWater();
      await fetchUserWorkOut();
    } else {
      print('No user ID found');
    }
  }

  Future<void> fetchUserGoals() async {
    if (userId != null) {
      GoalsModel? goals = await _repository.getUserGoals(userId!);
      if (goals != null) {
        watergoal = goals.waterGoal;
        caloriesGoal = goals.caloriesGoal;
        durationgoal = goals.exerciseDurationGoal;
        watergoalsml=(watergoal!*1000)!;
        print('Goals fetched: watergoal: $watergoal, caloriesGoal: $caloriesGoal, durationgoal: $durationgoal');
      } else {
        print('empty data/user goals');
      }
    } else {
      print('userid null/get goals');
    }
  }

  Future<void> fetchUserWater() async {
    if (userId != null) {
      WaterProgress? waterProgress = await _repository.getUserWater(userId!);
      if (waterProgress != null) {
        amount = waterProgress.mount;
        print('Water amount fetched: $amount');
      } else {
        print('empty data/user water');
      }
    } else {
      print('userid null/get water');
    }
  }

  Future<void> fetchUserWorkOut() async {
    if (userId != null) {
      WorkOutModel? workout = await _repository.getUserWorkOut(userId!);
      if (workout != null) {
        durationwork = workout.duration;
        print('Workout duration fetched: $durationwork');
      } else {
        print('empty data/user workout');
      }
    } else {
      print('userid null/get workout');
    }
  }

  double calculateProgress(double targetduration,double targetwater, double actualduation,double actualwater) {
    if (targetduration <= 0&&targetwater<=0) return 0;
    else if  (amount! >=targetwater&& durationwork!>=targetduration) return 1;
    else
    return ((actualduation+actualwater) /(targetduration+targetwater) ).clamp(0, 1);
  }

  Future<double?> calculateDailyProgress() async {
    double todayWorkout = durationwork?.toDouble() ?? 0.0;
    double todaywater = amount?.toDouble()?? 0.0;
    progress = calculateProgress(durationgoal?.toDouble() ?? 0.0,watergoalsml?.toDouble() ?? 0.0, todayWorkout,todaywater);
    print('Daily Progress: $progress');
    return progress;
    //notifyListeners();
  }

  Future<double?> calculateWeeklyProgress() async {
    double todayWorkout = durationwork?.toDouble() ?? 0.0;
    double todaywater = amount?.toDouble()?? 0.0;
    progress = calculateProgress((durationgoal!*7),(watergoalsml!*7),(todayWorkout*7) ,(todaywater*7));
    print('weekly Progress: $progress');
    return progress;
    //notifyListeners();
  }


  Future<double?> calculateManthlyProgress() async {
    double todayWorkout = durationwork?.toDouble() ?? 0.0;
    double todaywater = amount?.toDouble()?? 0.0;
    progress = calculateProgress((durationgoal!*30),(watergoalsml!*30),(todayWorkout*30) ,(todaywater*30));
    print('weekly Progress: $progress');
    return progress;
    //notifyListeners();
  }


  Future<double?> calculateYearlyProgress() async {
    double todayWorkout = durationwork?.toDouble() ?? 0.0;
    double todaywater = amount?.toDouble()?? 0.0;
    progress = calculateProgress((durationgoal!*256),(watergoalsml!*256),(todayWorkout*256) ,(todaywater*256));
    print('weekly Progress: $progress');
    return progress;
    //notifyListeners();
  }




}