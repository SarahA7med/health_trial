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

  // upload goals dependency userid
  Future<void> saveUserGoals(String userId, GoalsModel goals) async {
    try {
      await _firestore
          .collection('goals')
          .doc(userId)
          .set(goals.toMap());

      print("Goals saved successfully");
    } catch (e) {
      print("Error saving goals: $e");
    }
  }

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
}