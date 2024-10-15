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
    fetchUserData(); // استدعاء fetchUserData عند إنشاء UserViewModel
  }

  // استدعاء لجلب userId
  Future<void> fetchUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      print('User ID: $userId');
    } else {
      print('No user ID found');
    }
  }

  // استدعاء لجلب بيانات المستخدم
  Future<void> fetchUserData() async {
    // جلب userId أولاً
    await fetchUserId();

    // التأكد من أن userId ليس فارغًا
    if (userId != null) {
      Users? user = await _repository.getUserData(userId!); // تمرير userId إلى الريبو
      if (user != null) {
        userName = user.name;
        //userWeight = user.weight;
        notifyListeners();
        // تحديث الـ View بعد تحميل البيانات
      }
    } else {
      print("User ID is null, cannot fetch user data.");
    }
  }

  // دالة لحفظ الأهداف
  Future<void> saveUserGoals(double waterGoal, int caloriesGoal, int exerciseDurationGoal) async {
    // التأكد من وجود userId قبل الحفظ
    if (userId != null) {
      try {
        // إعداد الأهداف وإرسالها إلى الريبو لحفظها
        GoalsModel goals = GoalsModel(
          waterGoal: (waterGoal * 10).toInt(), // تحويل المايه إلى ملليلتر
          caloriesGoal: caloriesGoal,
          exerciseDurationGoal: exerciseDurationGoal,
        );

        await _repository.saveUserGoals(userId!, goals); // تمرير userId إلى الريبو

        // تحديث القيم في الـ ViewModel
        this.waterGoal = waterGoal;
        this.caloriesGoal = caloriesGoal;
        this.exerciseDurationGoal = exerciseDurationGoal;
        notifyListeners(); // تحديث الـ View بعد حفظ الأهداف

        print("Goals saved successfully");
      } catch (e) {
        print("Error saving goals: $e");
      }
    } else {
      print("User ID is null, cannot save goals.");
    }
  }
}