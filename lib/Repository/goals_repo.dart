import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_trial/Models/user_model.dart';
import 'package:health_trial/Models/goals_model.dart';

class Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة لجلب بيانات المستخدم عن طريق userId
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

  // دالة لحفظ الأهداف عن طريق userId
  Future<void> saveUserGoals(String userId, GoalsModel goals) async {
    try {
      await _firestore
         //.collection('users')
        //  .doc(userId)
          .collection('goals')
          .doc(userId) // تحديد الوثيقة باسم ثابت
          .set(goals.toMap()); // تحويل الأهداف إلى Map قبل حفظها

      print("Goals saved successfully");
    } catch (e) {
      print("Error saving goals: $e");
    }
  }
}