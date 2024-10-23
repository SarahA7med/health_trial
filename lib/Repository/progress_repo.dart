import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_trial/Models/progressmodel.dart';

import '../Models/goals_model.dart';
import '../Models/water_progress.dart';

class ProgressRepo{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<GoalsModel?> getUserGoalsDaily(String userId) async {
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

  // Function to retrieve the latest workout session for the day (returns a WorkoutModel)
  Future<List<WorkOutModel>> getDailyWorkout(String userId) async {
    try {
      DateTime today = DateTime.now();
      DateTime startOfDay = DateTime(today.year, today.month, today.day); // Start of the day
      DateTime endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59); // End of the day

      QuerySnapshot snapshot = await _firestore.collection('workouts')
          .where('user_id', isEqualTo: userId)
          .where('start_time', isGreaterThanOrEqualTo: startOfDay) // Check if start_time is greater than or equal to the start of the day
          .where('start_time', isLessThanOrEqualTo: endOfDay) // Check if start_time is less than or equal to the end of the day
          .orderBy('start_time', descending: true) // Order results by latest
          .get();

      // Convert retrieved data into a list of WorkOutModel
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['start_time'] = (data['start_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        data['end_time'] = (data['end_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        return WorkOutModel.fromMap(data);
      }).toList();

    } catch (e) {
      print('Error retrieving daily workouts: $e');
      return []; // Return an empty list in case of an error
    }
  }

  // Function to retrieve all workout sessions for the week (returns a list of WorkoutModel)
  Future<List<WorkOutModel>> getWeeklyWorkouts(String userId) async {
    try {
      DateTime today = DateTime.now();
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1)); // Start of the week

      QuerySnapshot snapshot = await _firestore.collection('workouts')
          .where('user_id', isEqualTo: userId)
          .where('start_time', isGreaterThanOrEqualTo: startOfWeek)
          .orderBy('start_time') // Order results from oldest to newest
          .get();

      // Convert the retrieved data into a list of WorkoutModel objects
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['start_time'] = (data['start_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        data['end_time'] = (data['end_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        return WorkOutModel.fromMap(data);
      }).toList();

    } catch (e) {
      print('Error retrieving weekly workouts: $e');
      return []; // Return an empty list in case of an error
    }
  }


  // Function to retrieve all workout sessions for the month (returns a list of WorkoutModel)
  Future<List<WorkOutModel>> getMonthlyWorkouts(String userId) async {
    try {
      DateTime today = DateTime.now();
      DateTime startOfMonth = DateTime(today.year, today.month, 1); // Start of the month

      QuerySnapshot snapshot = await _firestore.collection('workouts')
          .where('user_id', isEqualTo: userId)
          .where('start_time', isGreaterThanOrEqualTo: startOfMonth)
          .orderBy('start_time') // Order results from oldest to newest
          .get();

      // Convert the retrieved data into a list of WorkoutModel objects
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['start_time'] = (data['start_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        data['end_time'] = (data['end_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        return WorkOutModel.fromMap(data);
      }).toList();

    } catch (e) {
      print('Error retrieving monthly workouts: $e');
      return []; // Return an empty list in case of an error
    }
  }


  // Function to retrieve all workout sessions for the year (returns a list of WorkoutModel)
  Future<List<WorkOutModel>> getYearlyWorkouts(String userId) async {
    try {
      DateTime today = DateTime.now();
      DateTime startOfYear = DateTime(today.year, 1, 1); // Start of the year

      QuerySnapshot snapshot = await _firestore.collection('workouts')
          .where('user_id', isEqualTo: userId)
          .where('start_time', isGreaterThanOrEqualTo: startOfYear)
          .orderBy('start_time') // Order results from oldest to newest
          .get();

      // Convert the retrieved data into a list of WorkoutModel objects
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['start_time'] = (data['start_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        data['end_time'] = (data['end_time'] as Timestamp).toDate(); // Convert Timestamp to DateTime
        return WorkOutModel.fromMap(data);
      }).toList();

    } catch (e) {
      print('Error retrieving yearly workouts: $e');
      return []; // Return an empty list in case of an error
    }
  }


  Future<List<WaterProgress>> getDailyWaterIntake(String userId) async {
    try {

      DateTime today = DateTime.now();

      DateTime startOfDay = DateTime(today.year, today.month, today.day);

      DateTime endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);


      QuerySnapshot snapshot = await _firestore.collection('waterIntake')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .orderBy('timestamp', descending: true)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          data['timestamp'] = (data['timestamp'] as Timestamp).toDate();
          return WaterProgress.fromMap(data);
        }).toList();
      } else {
        print('No water intake records found for user: $userId today');
        return []; // Return an empty list if no records found
      }
    } catch (e) {
      print('Error retrieving daily water intake: $e');
      return [];
    }
  }



  Future<List<WaterProgress>> getWeeklyWaterIntake(String userId) async {
    print("water $userId ");
    try {
      DateTime today = DateTime.now();
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

      QuerySnapshot snapshot = await _firestore.collection('waterIntake')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThanOrEqualTo: startOfWeek)
          .orderBy('timestamp')
          .get();

      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;

        data['timestamp'] = (data['timestamp'] as Timestamp).toDate();
        return WaterProgress.fromMap(data);
      }).toList();

    } catch (e) {
      print('Error retrieving weekly water intake: $e');
      return [];
    }
  }


  Future<List<WaterProgress>> getMonthlyWaterIntake(String userId) async {
    try {
      DateTime today = DateTime.now();
      DateTime startOfMonth = DateTime(today.year, today.month, 1);

      QuerySnapshot snapshot = await _firestore.collection('waterIntake')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThanOrEqualTo: startOfMonth)
          .orderBy('timestamp')
          .get();

      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;

        data['timestamp'] = (data['timestamp'] as Timestamp).toDate();
        return WaterProgress.fromMap(data);
      }).toList();

    } catch (e) {
      print('Error retrieving monthly water intake: $e');
      return [];
    }
  }


  Future<List<WaterProgress>> getYearlyWaterIntake(String userId) async {
    try {
      DateTime today = DateTime.now();
      DateTime startOfYear = DateTime(today.year, 1, 1);

      QuerySnapshot snapshot = await _firestore.collection('waterIntake')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThanOrEqualTo: startOfYear)
          .orderBy('timestamp')
          .get();

      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;

        data['timestamp'] = (data['timestamp'] as Timestamp).toDate();
        return WaterProgress.fromMap(data);
      }).toList();

    } catch (e) {
      print('Error retrieving yearly water intake: $e');
      return [];
    }}}