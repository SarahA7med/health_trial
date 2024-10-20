import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/Repository/progress_repo.dart';
import '../Models/goals_model.dart';
import '../Models/progressmodel.dart';
import '../Models/water_progress.dart';

class ProgressViewModel extends ChangeNotifier {
  ProgressViewModel()  {
    fetchUserId();
    fetchUserGoalsDaily();
    fetchWeeklyGoals(userId!);
    fetchMonthlyGoals(userId!);
    fetchYearlyGoals(userId!);
    fetchDailyWaterIntake(userId!);
    fetchMonthlyWaterIntake(userId!);
    fetchYearlyWaterIntake(userId!);
    fetchWeeklyWaterIntake(userId!);
    fetchDailyWorkout(userId!);
    fetchWeeklyWorkouts(userId!);
    fetchMonthlyWorkouts(userId!);
    fetchYearlyWorkouts(userId!);

  }
 String? userId;
 double? progress; //from 0 to 1
 double? waterGoalsDaily;

 int? exerciseDurationGoalDaily;
 List<GoalsModel> _weeklyGoals = [];
 List<GoalsModel> get weeklyGoals => _weeklyGoals;
 double _totalWeeklyWaterGoals = 0;
 double get totalWeeklyWaterGoals => _totalWeeklyWaterGoals;
 int _totalWeeklyExerciseDurationGoals = 0;
 int get totalWeeklyExerciseDuration => _totalWeeklyExerciseDurationGoals;
 List<GoalsModel> _monthlyGoals = [];
 List<GoalsModel> get monthlyGoals => _monthlyGoals;
 double _totalMonthlyWaterGoals = 0;
 double get totalMonthlyWaterGoals => _totalMonthlyWaterGoals;
 int _totalMonthlyExerciseDurationGoals = 0;
 int get totalMonthlyExerciseDuration => _totalMonthlyExerciseDurationGoals;

 List<GoalsModel> _yearlyGoals = [];
 List<GoalsModel> get yearlyGoals => _yearlyGoals;
 double _totalYearlyWaterGoals = 0;
 double get totalYearlyWaterGoals => _totalYearlyWaterGoals;

 int _totalYearlyExerciseDurationGoals = 0;
 int get totalYearlyExerciseDuration => _totalYearlyExerciseDurationGoals;

double dailyDurationWorkout = 0;
double totalWeeklyDurationWorkout = 0;
double totalMonthlyDurationWOrkout = 0;
double  totalYearlyDurationWorkout = 0;
 int dailyWaterIntake = 0;
 int totalWeeklyWaterIntake = 0;
 int totalMonthlyWaterIntake = 0;
 int totalYearlyWaterIntake = 0;


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
       print("data complete goals");
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
   _totalWeeklyWaterGoals = _weeklyGoals.fold(0, (sum, goal) => sum +goal.waterGoal);
   _totalWeeklyExerciseDurationGoals = _weeklyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);

   notifyListeners();
 }
 Future<void> fetchMonthlyGoals(String userId) async {
   _monthlyGoals = await _repository.getMonthlyGoals(userId);


   _totalMonthlyWaterGoals = _monthlyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
   _totalMonthlyExerciseDurationGoals = _monthlyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);

   notifyListeners();
 }
 Future<void> fetchYearlyGoals(String userId) async {
   _yearlyGoals = await _repository.getYearlyGoals(userId);


   _totalYearlyWaterGoals = _yearlyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
   _totalYearlyExerciseDurationGoals = _yearlyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);

   notifyListeners();
 }


 // Function to fetch daily workout duration
 Future<void> fetchDailyWorkout(String userId) async {
   try {
     WorkOutModel? dailyWorkout = await _repository.getDailyWorkout(userId);
     if (dailyWorkout != null) {
       dailyDurationWorkout = dailyWorkout.duration; // Set daily duration
       print('data complete workout');
     } else {
       dailyDurationWorkout = 0;// Reset if no workout found
       print('data empty workout');
     }
   } catch (e) {
     print("Error fetching daily workout: $e");
     dailyDurationWorkout = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }

 // Function to fetch total weekly workout duration
 Future<void> fetchWeeklyWorkouts(String userId) async {
   try {
     List<WorkOutModel> weeklyWorkouts = await _repository.getWeeklyWorkouts(userId);
     totalWeeklyDurationWorkout = weeklyWorkouts.fold(0, (sum, workout) => sum + workout.duration); // Sum up durations
   } catch (e) {
     print("Error fetching weekly workouts: $e");
     totalWeeklyDurationWorkout = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }

 // Function to fetch total monthly workout duration
 Future<void> fetchMonthlyWorkouts(String userId) async {
   try {
     List<WorkOutModel> monthlyWorkouts = await _repository.getMonthlyWorkouts(userId);
     totalMonthlyDurationWOrkout = monthlyWorkouts.fold(0, (sum, workout) => sum + workout.duration); // Sum up durations
   } catch (e) {
     print("Error fetching monthly workouts: $e");
     totalMonthlyDurationWOrkout = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }

 // Function to fetch total yearly workout duration
 // Function to fetch total yearly workout duration
 Future<void> fetchYearlyWorkouts(String userId) async {
   try {
     List<WorkOutModel> yearlyWorkouts = await _repository.getYearlyWorkouts(userId);
     totalYearlyDurationWorkout = yearlyWorkouts.fold(0, (sum, workout) => sum + workout.duration); // Sum up durations
   } catch (e) {
     print("Error fetching yearly workouts: $e");
     totalYearlyDurationWorkout = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }
 // Function to fetch daily water intake
 Future<void> fetchDailyWaterIntake(String userId) async {
   try {
     WaterProgress? dailyWater = await _repository.getDailyWaterIntake(userId);
     if (dailyWater != null) {
       dailyWaterIntake = dailyWater.mount; // Set daily water intake
     } else {
       dailyWaterIntake = 0; // Reset if no intake found
     }
   } catch (e) {
     print("Error fetching daily water intake: $e");
     dailyWaterIntake = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }

 // Function to fetch total weekly water intake
 Future<void> fetchWeeklyWaterIntake(String userId) async {
   try {
     List<WaterProgress> weeklyWaterIntakes = await _repository.getWeeklyWaterIntake(userId);
     totalWeeklyWaterIntake = weeklyWaterIntakes.fold(0, (sum, water) => sum + water.mount); // Sum up water intake
   } catch (e) {
     print("Error fetching weekly water intake: $e");
     totalWeeklyWaterIntake = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }

 // Function to fetch total monthly water intake
 Future<void> fetchMonthlyWaterIntake(String userId) async {
   try {
     List<WaterProgress> monthlyWaterIntakes = await _repository.getMonthlyWaterIntake(userId);
     totalMonthlyWaterIntake = monthlyWaterIntakes.fold(0, (sum, water) => sum + water.mount); // Sum up water intake
   } catch (e) {
     print("Error fetching monthly water intake: $e");
     totalMonthlyWaterIntake = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }

 // Function to fetch total yearly water intake
 // Function to fetch total yearly water intake
 Future<void> fetchYearlyWaterIntake(String userId) async {
   try {
     List<WaterProgress> yearlyWaterIntakes = await _repository.getYearlyWaterIntake(userId);
     totalYearlyWaterIntake = yearlyWaterIntakes.fold(0, (sum, water) => sum + water.mount); // Sum up water intake
   } catch (e) {
     print("Error fetching yearly water intake: $e");
     totalYearlyWaterIntake = 0; // Reset on error
   }
   notifyListeners(); // Notify listeners to update UI
 }
// Function to calculate daily progress for water intake and workout duration
  double calculateDailyProgress() {
    fetchUserId();
    fetchUserGoalsDaily();
    fetchDailyWorkout(userId!);
    fetchDailyWaterIntake(userId!);
    // Check if daily goals are set
    if (waterGoalsDaily != null && exerciseDurationGoalDaily != null) {
      // Check if the daily intake meets or exceeds the goals
      if (dailyWaterIntake >= (waterGoalsDaily!*1000 )&& dailyDurationWorkout >= (exerciseDurationGoalDaily!*60)) {
        return progress = 1; // Full progress if both goals are met
      } else if (dailyWaterIntake == null && dailyDurationWorkout == null) {
       return progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for water intake and workout duration
        double waterProgress = dailyWaterIntake /( waterGoalsDaily!*1000);
        double workoutProgress = (dailyDurationWorkout/60) / (exerciseDurationGoalDaily ?? 1);

        // Calculate average progress
        progress = (waterProgress + workoutProgress) / 2;
       return progress = progress!.clamp(0, 1); // Ensure the value is between 0 and 1
      }
    } else {
      return progress = 0; // Reset progress if goals are not set
    }
    notifyListeners(); // Notify listeners to update UI
  }

  double calculateWeeklyProgress() {
    fetchUserId();
    fetchWeeklyGoals(userId!);
    fetchWeeklyWorkouts(userId!);
    fetchWeeklyWaterIntake(userId!);
    // Check if weekly goals are set
    if (totalWeeklyWaterGoals != 0 && _totalWeeklyExerciseDurationGoals  != 0) {
      // Check if the total weekly intake meets or exceeds the goals
      if (totalWeeklyWaterIntake >= (totalWeeklyWaterGoals*1000) && totalWeeklyDurationWorkout >= (_totalWeeklyExerciseDurationGoals*60 )) {
       return progress = 1; // Full progress if both goals are met
      } else if (totalWeeklyWaterIntake == 0 && totalWeeklyDurationWorkout == 0) {
         return progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for weekly water intake and workout duration
        double waterProgress = totalWeeklyWaterIntake / (totalWeeklyWaterGoals*1000);
     double workoutProgress = (totalWeeklyDurationWorkout/60) / _totalWeeklyExerciseDurationGoals ;

        // Calculate average progress
        progress = (waterProgress + workoutProgress) / 2;
       return progress = progress!.clamp(0, 1); // Ensure the value is between 0 and 1
      }
    } else {
    return  progress = 0; // Reset progress if goals are not set
    }
    notifyListeners(); // Notify listeners to update UI
  }
  double calculateMonthlyProgress() {
    fetchUserId();
    fetchMonthlyGoals(userId!);
    fetchMonthlyWorkouts(userId!);
    fetchMonthlyWaterIntake(userId!);
    // Check if monthly goals are set
    if (totalMonthlyWaterGoals != 0 && _totalMonthlyWaterGoals != 0) {
      // Check if the total monthly intake meets or exceeds the goals
      if (totalMonthlyWaterIntake >= (totalMonthlyWaterGoals*1000) && totalMonthlyDurationWOrkout >=( _totalMonthlyWaterGoals*60)) {
       return progress = 1; // Full progress if both goals are met
      } else if (totalMonthlyWaterIntake == 0 && totalMonthlyDurationWOrkout == 0) {
      return  progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for monthly water intake and workout duration
        double waterProgress = totalMonthlyWaterIntake / (totalMonthlyWaterGoals*1000);
        double workoutProgress =(totalMonthlyDurationWOrkout/60) / _totalMonthlyWaterGoals;

        // Calculate average progress
        progress = (waterProgress + workoutProgress) / 2;
       return   progress = progress!.clamp(0, 1); // Ensure the value is between 0 and 1
      }
    } else {
     return progress = 0; // Reset progress if goals are not set
    }
    notifyListeners(); // Notify listeners to update UI
  }
double calculateYearlyProgress() {
 fetchUserId();
    fetchYearlyGoals(userId!);
    fetchYearlyWorkouts(userId!);
    fetchYearlyWaterIntake(userId!);
    // Check if yearly goals are set
    if (totalYearlyWaterGoals != 0 && _totalYearlyExerciseDurationGoals != 0) {
      print("year goals ");
      // Check if the total yearly intake meets or exceeds the goals
      if (totalYearlyWaterIntake >= (totalYearlyWaterGoals*1000) && totalYearlyDurationWorkout >= (_totalYearlyExerciseDurationGoals*60) ) {
      return  progress = 1; // Full progress if both goals are met
      } else if (totalYearlyWaterIntake == 0 && totalYearlyDurationWorkout == 0) {
       return progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for yearly water intake and workout duration
        double waterProgress = totalYearlyWaterIntake / (totalYearlyWaterGoals*1000);
        double workoutProgress = (totalYearlyDurationWorkout/60) / _totalYearlyExerciseDurationGoals ;

        // Calculate average progress
        progress = (waterProgress + workoutProgress) / 2;
       return  progress = progress!.clamp(0, 1); // Ensure the value is between 0 and 1
      }
    } else {
     return progress = 0; // Reset progress if goals are not set
    }
    notifyListeners(); // Notify listeners to update UI
  }
 }







