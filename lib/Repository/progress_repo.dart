import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_trial/Models/progressmodel.dart';

import '../Models/goals_model.dart';
import '../Models/water_progress.dart';

class ProgressRepo{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<GoalsModel?> getUserGoalsDaily(String userId) async {
    try {

      DocumentSnapshot snapshot = await _firestore
          .collection('goals')
          .doc(userId)
          .collection('user goals')
          .doc(DateTime.now().toIso8601String())
          .get();

      if (snapshot.exists) {

        return GoalsModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        print("No goals found for today.");
        return null;
      }
    } catch (e) {
      print("Error retrieving goals: $e");
      return null;
    }}

  // weekly goals
  Future<List<GoalsModel>> getWeeklyGoals(String userId) async {
    try {
      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(Duration(days: 7));
      String startDate = sevenDaysAgo.toIso8601String().split('T')[0];
      String todayDate = now.toIso8601String().split('T')[0];

      QuerySnapshot snapshot = await _firestore
          .collection('goals')
          .doc(userId)
          .collection('user goals')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThanOrEqualTo: todayDate)
          .get();

      return snapshot.docs.map((doc) => GoalsModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error retrieving weekly goals: $e");
      return [];
    }
  }
  // دالة لاسترجاع الأهداف لآخر 30 يوم من اليوم الحالي
  Future<List<GoalsModel>> getMonthlyGoals(String userId) async {
    try {
      DateTime now = DateTime.now();
      DateTime thirtyDaysAgo = now.subtract(Duration(days: 30));
      String startDate = thirtyDaysAgo.toIso8601String().split('T')[0];
      String todayDate = now.toIso8601String().split('T')[0];

      QuerySnapshot snapshot = await _firestore
          .collection('goals')
          .doc(userId)
          .collection('user goals')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThanOrEqualTo: todayDate)
          .get();

      return snapshot.docs.map((doc) => GoalsModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error retrieving monthly goals: $e");
      return [];
    }
  }
  // دالة لاسترجاع الأهداف لآخر 365 يوم من اليوم الحالي
  Future<List<GoalsModel>> getYearlyGoals(String userId) async {
    try {
      DateTime now = DateTime.now();
      DateTime oneYearAgo = now.subtract(Duration(days: 365));
      String startDate = oneYearAgo.toIso8601String().split('T')[0];
      String todayDate = now.toIso8601String().split('T')[0];

      QuerySnapshot snapshot = await _firestore
          .collection('goals')
          .doc(userId)
          .collection('user goals')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThanOrEqualTo: todayDate)
          .get();

      return snapshot.docs.map((doc) => GoalsModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error retrieving yearly goals: $e");
      return [];
    }
  }
  Future<WorkOutModel?> getUserWorkOutDaily(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('workouts').doc(userId).get();
      if (doc.exists) {
        return WorkOutModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user workout: $e");
    }
    return null;
  }

  Future<WaterProgress?> getUserWaterDaily(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('workouts').doc(userId).get();
      if (doc.exists) {
        return WaterProgress.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user workout: $e");
    }
    return null;
  }
}