import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_trial/Models/progressmodel.dart';

import '../Models/goals_model.dart';
import '../Models/water_progress.dart';

class ProgressRepo{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // download goals from firestore
  Future<GoalsModel?> getUserGoals(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('goals').doc(userId).get();
      if (doc.exists) {
        return GoalsModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user goals: $e");
    }
    return null;
  }
//download workout
  Future<WorkOutModel?> getUserWorkOut(String userId) async {
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

  Future<WaterProgress?> getUserWater(String userId) async {
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