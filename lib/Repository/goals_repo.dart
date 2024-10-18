import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_trial/Models/user_model.dart';
import 'package:health_trial/Models/goals_model.dart';

class Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // download user data from fire store
  Future<Users?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return Users.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }
  Future<void> saveUserGoals(String userId, double waterGoal, int caloriesGoal, int exerciseDurationGoal) async {
    try {
      String todayDate = DateTime.now().toIso8601String().split('T')[0]; //only date without time
      GoalsModel goals = GoalsModel(
        waterGoal: waterGoal,
        caloriesGoal: caloriesGoal,
        exerciseDurationGoal: exerciseDurationGoal,
        date: todayDate,
      );


      await _firestore
          .collection('goals')
          .doc(userId)
          .collection('user goals')
          .doc(todayDate)
          .set(goals.toMap());

      print("Goals saved successfully");
    } catch (e) {
      print("Error saving goals: $e");
    }
  }

  // upload goals dependency userid
  Future<GoalsModel?> getUserGoals(String userId) async {
    try {
      String todayDate = DateTime.now().toIso8601String().split('T')[0];
      DocumentSnapshot snapshot = await _firestore
          .collection('goals')
          .doc(userId)
          .collection('user goals')
          .doc(todayDate)
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
    }
  }




}