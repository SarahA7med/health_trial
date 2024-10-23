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
  double? progress; // from 0 to 1
  double? waterGoalsDaily;
  int? exerciseDurationGoalDaily;
  int? calorieGoalDaily;

  List<GoalsModel> _weeklyGoals = [];
  List<GoalsModel> get weeklyGoals => _weeklyGoals;
  double _totalWeeklyWaterGoals = 0;
  double get totalWeeklyWaterGoals => _totalWeeklyWaterGoals;
  int _totalWeeklyExerciseDurationGoals = 0;
  int get totalWeeklyExerciseDuration => _totalWeeklyExerciseDurationGoals;
  int _totalWeeklyCalorieGoals = 0;
  int get totalWeeklyCalorieGoals => _totalWeeklyCalorieGoals;

  List<GoalsModel> _monthlyGoals = [];
  List<GoalsModel> get monthlyGoals => _monthlyGoals;
  double _totalMonthlyWaterGoals = 0;
  double get totalMonthlyWaterGoals => _totalMonthlyWaterGoals;
  int _totalMonthlyExerciseDurationGoals = 0;
  int get totalMonthlyExerciseDuration => _totalMonthlyExerciseDurationGoals;
  int _totalMonthlyCalorieGoals = 0;
  int get totalMonthlyCalorieGoals => _totalMonthlyCalorieGoals;

  List<GoalsModel> _yearlyGoals = [];
  List<GoalsModel> get yearlyGoals => _yearlyGoals;
  double _totalYearlyWaterGoals = 0;
  double get totalYearlyWaterGoals => _totalYearlyWaterGoals;
  int _totalYearlyExerciseDurationGoals = 0;
  int get totalYearlyExerciseDuration => _totalYearlyExerciseDurationGoals;
  int _totalYearlyCalorieGoals = 0;
  int get totalYearlyCalorieGoals => _totalYearlyCalorieGoals;

 int dailyDurationWorkout = 0;
  int totalWeeklyDurationWorkout = 0;
int totalMonthlyDurationWorkout = 0;
 int totalYearlyDurationWorkout = 0;

  int dailyWaterIntake = 0;
  int totalWeeklyWaterIntake = 0;
  int totalMonthlyWaterIntake = 0;
  int totalYearlyWaterIntake = 0;

  double dailyCaloriesBurned = 0;
  double totalWeeklyCaloriesBurned = 0;
 double totalMonthlyCaloriesBurned = 0;
  double totalYearlyCaloriesBurned = 0;

  double? workoutProgressYearly=0;
   double? caloriesYealryProgress=0;
   double? waterProgressYearly=0;
  double waterProgressMontly=0;
  double workoutProgressMonthly=0;
  double caloriesManthlyProgress=0;
  double?waterProgressWeekly=0;
  double?workoutProgressWeekly=0;
  double? caloriesWeeklyProgress=0;
  double?caloriesProgressDaily=0;
  double? waterProgressDaily=0;
  double?workoutProgressDaily=0;
  final ProgressRepo _repository = ProgressRepo();

  // Fetch user ID
  Future<void> fetchUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      print('User ID: $userId');
    } else {
      print('No user ID found');
    }
    notifyListeners();
  }

  // Fetch daily goals including calories burned
  Future<void> fetchUserGoalsDaily() async {
    await fetchUserId();
    if (userId != null) {
      GoalsModel? goals = await _repository.getUserGoalsDaily(userId!);
      if (goals != null) {
        waterGoalsDaily = goals.waterGoal;
        exerciseDurationGoalDaily = goals.exerciseDurationGoal;
        calorieGoalDaily = goals.caloriesGoal; // Fetch daily calorie goal
        notifyListeners();
      } else {
        print('Empty data for user goals');
      }
    } else {
      print('User ID is null while fetching goals');
    }
  }

  // Fetch weekly goals including calories burned
  Future<void> fetchWeeklyGoals(String userId) async {
    print("userid $userId");
    _weeklyGoals = await _repository.getWeeklyGoals(userId);
    _totalWeeklyWaterGoals = _weeklyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
    _totalWeeklyExerciseDurationGoals = _weeklyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);
    _totalWeeklyCalorieGoals = _weeklyGoals.fold(0, (sum, goal) => sum + goal.caloriesGoal); // Sum weekly calorie goals
    notifyListeners();
  }

  // Fetch monthly goals including calories burned
  Future<void> fetchMonthlyGoals(String userId) async {
    _monthlyGoals = await _repository.getMonthlyGoals(userId);
    _totalMonthlyWaterGoals = _monthlyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
    _totalMonthlyExerciseDurationGoals = _monthlyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);
    _totalMonthlyCalorieGoals = _monthlyGoals.fold(0, (sum, goal) => sum + goal.caloriesGoal); // Sum monthly calorie goals
    notifyListeners();
  }

  // Fetch yearly goals including calories burned
  Future<void> fetchYearlyGoals(String userId) async {
    _yearlyGoals = await _repository.getYearlyGoals(userId);
    _totalYearlyWaterGoals = _yearlyGoals.fold(0, (sum, goal) => sum + goal.waterGoal);
    _totalYearlyExerciseDurationGoals = _yearlyGoals.fold(0, (sum, goal) => sum + goal.exerciseDurationGoal);
    _totalYearlyCalorieGoals = _yearlyGoals.fold(0, (sum, goal) => sum + goal.caloriesGoal); // Sum yearly calorie goals
    notifyListeners();
  }

  // Fetch daily workout including calories burned
  Future<void> fetchDailyWorkout(String userId) async {
    try {
    List<WorkOutModel> dailyWorkout = await _repository.getDailyWorkout(userId);
    print(dailyWorkout);
      if (dailyWorkout != null) {
        dailyDurationWorkout = dailyWorkout.fold(0, (sum,workout)=>sum+workout.duration);
        print(" workout $dailyDurationWorkout");
        dailyCaloriesBurned = dailyWorkout.fold(0, (sum,workout)=>sum+workout.calories_burned); // Fetch calories burned
        print('Workout data fetched');
      } else {
        dailyDurationWorkout = 0;
        dailyCaloriesBurned = 0; // Reset if no data found
        print('No workout data found');
      }
    } catch (e) {
      print("Error fetching daily workout: $e");
      dailyDurationWorkout = 0;
      dailyCaloriesBurned = 0; // Reset on error
    }
    notifyListeners();
  }

  // Fetch weekly workout including calories burned
  Future<void> fetchWeeklyWorkouts(String userId) async {
    try {
      List<WorkOutModel> weeklyWorkouts = await _repository.getWeeklyWorkouts(userId);
      totalWeeklyDurationWorkout = weeklyWorkouts.fold(0, (sum, workout) => sum + workout.duration);
      totalWeeklyCaloriesBurned = weeklyWorkouts.fold(0, (sum, workout) => sum + workout.calories_burned); // Sum weekly calories burned
    } catch (e) {
      print("Error fetching weekly workouts: $e");
      totalWeeklyDurationWorkout = 0;
      totalWeeklyCaloriesBurned = 0; // Reset on error
    }
    notifyListeners();
  }

  // Fetch monthly workout including calories burned
  Future<void> fetchMonthlyWorkouts(String userId) async {
    try {
      List<WorkOutModel> monthlyWorkouts = await _repository.getMonthlyWorkouts(userId);
      totalMonthlyDurationWorkout = monthlyWorkouts.fold(0, (sum, workout) => sum + workout.duration);
      totalMonthlyCaloriesBurned = monthlyWorkouts.fold(0, (sum, workout) => sum + workout.calories_burned); // Sum monthly calories burned
    } catch (e) {
      print("Error fetching monthly workouts: $e");
      totalMonthlyDurationWorkout = 0;
      totalMonthlyCaloriesBurned = 0; // Reset on error
    }
    notifyListeners();
  }

  // Fetch yearly workout including calories burned
  Future<void> fetchYearlyWorkouts(String userId) async {
    try {
      List<WorkOutModel> yearlyWorkouts = await _repository.getYearlyWorkouts(userId);
      totalYearlyDurationWorkout = yearlyWorkouts.fold(0, (sum, workout) => sum + workout.duration);
      totalYearlyCaloriesBurned = yearlyWorkouts.fold(0, (sum, workout) => sum + workout.calories_burned); // Sum yearly calories burned
    } catch (e) {
      print("Error fetching yearly workouts: $e");
      totalYearlyDurationWorkout = 0;
      totalYearlyCaloriesBurned = 0; // Reset on error
    }
    notifyListeners();
  }

  // Fetch daily water intake
  Future<void> fetchDailyWaterIntake(String userId) async {
    try {
     List< WaterProgress>dailyWater = await _repository.getDailyWaterIntake(userId);
     print("water $dailyWater");
      if (dailyWater != null) {
        dailyWaterIntake = dailyWater.fold(0, (sum, water) => sum + water.amount);
        print(" water $dailyWaterIntake");
      } else {
        dailyWaterIntake = 0;
        print("water $dailyWaterIntake");
      }
    } catch (e) {
      print("Error fetching daily water intake: $e");
      dailyWaterIntake = 0;
    }
    notifyListeners();
  }

  // Fetch weekly water intake
  Future<void> fetchWeeklyWaterIntake(String userId) async {
    try {
      List<WaterProgress> weeklyWater = await _repository.getWeeklyWaterIntake(userId);
      totalWeeklyWaterIntake = weeklyWater.fold(0, (sum, water) => sum + water.amount);
      print(" water $totalWeeklyWaterIntake");
    } catch (e) {
      print("Error fetching weekly water intake: $e");
      totalWeeklyWaterIntake = 0;
    }
    notifyListeners();
  }

  // Fetch monthly water intake
  Future<void> fetchMonthlyWaterIntake(String userId) async {
    try {
      List<WaterProgress> monthlyWater = await _repository.getMonthlyWaterIntake(userId);
      totalMonthlyWaterIntake = monthlyWater.fold(0, (sum, water) => sum + water.amount);
    } catch (e) {
      print("Error fetching monthly water intake: $e");
      totalMonthlyWaterIntake = 0;
    }
    notifyListeners();
  }

  // Fetch yearly water intake
  Future<void> fetchYearlyWaterIntake(String userId) async {
    try {
      List<WaterProgress> yearlyWater = await _repository.getYearlyWaterIntake(userId);
      totalYearlyWaterIntake = yearlyWater.fold(0, (sum, water) => sum + water.amount);
    } catch (e) {
      print("Error fetching yearly water intake: $e");
      totalYearlyWaterIntake = 0;
    }
    notifyListeners();
  }
  double calculateDailyProgress() {
    fetchUserId();
    fetchUserGoalsDaily();
    fetchDailyWorkout(userId!);
    fetchDailyWaterIntake(userId!);
    // Check if daily goals are set
    if (waterGoalsDaily != null && exerciseDurationGoalDaily != null&&calorieGoalDaily!=null) {
      // Check if the daily intake meets or exceeds the goals
      if (dailyWaterIntake >= (waterGoalsDaily!*1000 )&& dailyDurationWorkout >= (exerciseDurationGoalDaily!*60)&&calorieGoalDaily! >= dailyCaloriesBurned) {
        return progress = 1; // Full progress if both goals are met
      } else if (dailyWaterIntake == null && dailyDurationWorkout == null&&dailyCaloriesBurned== null) {
        return progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for water intake and workout duration
       waterProgressDaily = dailyWaterIntake /( waterGoalsDaily!*1000) ;
       workoutProgressDaily = (dailyDurationWorkout/60) / (exerciseDurationGoalDaily ?? 1);
         caloriesProgressDaily=dailyCaloriesBurned/calorieGoalDaily!;
       notifyListeners();
        // Calculate average progress
        progress = (waterProgressDaily!.clamp(0,1) + workoutProgressDaily!.clamp(0,1)+ caloriesProgressDaily!.clamp(0,1)) *(1/3);
        return progress = progress!.clamp(0, 1); // Ensure the value is between 0 and 1
      }
    } else {
      return progress = 0; // Reset progress if goals are not set
    }
    notifyListeners();
  }
  double calculateWeeklyProgress() {
    fetchUserId();
    fetchWeeklyGoals(userId!);
    fetchWeeklyWorkouts(userId!);
    fetchWeeklyWaterIntake(userId!);
    // Check if weekly goals are set
    if (totalWeeklyWaterGoals != 0 && _totalWeeklyExerciseDurationGoals  != 0&&_totalWeeklyCalorieGoals!=0) {
      // Check if the total weekly intake meets or exceeds the goals
      if (totalWeeklyWaterIntake >= (totalWeeklyWaterGoals*1000) && totalWeeklyDurationWorkout >= (_totalWeeklyExerciseDurationGoals*60 )&&totalWeeklyCaloriesBurned>=totalWeeklyCalorieGoals) {
        return progress = 1; // Full progress if both goals are met
      } else if (totalWeeklyWaterIntake == 0 && totalWeeklyDurationWorkout == 0&&totalWeeklyCaloriesBurned==0) {
        return progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for weekly water intake and workout duration
        waterProgressWeekly = totalWeeklyWaterIntake / (totalWeeklyWaterGoals*1000);

        workoutProgressWeekly = (totalWeeklyDurationWorkout/60) / _totalWeeklyExerciseDurationGoals ;
        caloriesWeeklyProgress=totalWeeklyCaloriesBurned/totalWeeklyCalorieGoals;
        notifyListeners();
        // Calculate average progress
        progress = (waterProgressWeekly!.clamp(0,1) + workoutProgressWeekly!.clamp(0,1)+caloriesWeeklyProgress!.clamp(0,1)) *(1/3);
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
      if (totalMonthlyWaterIntake >= (totalMonthlyWaterGoals*1000) && totalMonthlyDurationWorkout >=( _totalMonthlyWaterGoals*60)&&totalMonthlyCaloriesBurned>=totalMonthlyCalorieGoals) {
        return progress = 1; // Full progress if both goals are met
      } else if (totalMonthlyWaterIntake == 0 && totalMonthlyDurationWorkout == 0&&totalMonthlyCaloriesBurned==0) {
        return  progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for monthly water intake and workout duration
       waterProgressMontly = totalMonthlyWaterIntake / (totalMonthlyWaterGoals*1000);
         workoutProgressMonthly =(totalMonthlyDurationWorkout/60) / _totalMonthlyExerciseDurationGoals;
        caloriesManthlyProgress=totalMonthlyCaloriesBurned/totalMonthlyCalorieGoals;
       notifyListeners();
        // Calculate average progress
        progress = (waterProgressMontly.clamp(0,1) + workoutProgressMonthly.clamp(0,1)+caloriesManthlyProgress.clamp(0,1)) *(1/3);
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
    if (totalYearlyWaterGoals != 0 && _totalYearlyExerciseDurationGoals != 0&&totalYearlyCalorieGoals!=0) {
      print("year goals ");
      // Check if the total yearly intake meets or exceeds the goals
      if (totalYearlyWaterIntake >= (totalYearlyWaterGoals*1000) && totalYearlyDurationWorkout >= (_totalYearlyExerciseDurationGoals*60)&&totalYearlyCaloriesBurned>=totalYearlyCalorieGoals ) {
        return  progress = 1; // Full progress if both goals are met
      } else if (totalYearlyWaterIntake == 0 && totalYearlyDurationWorkout == 0&&totalYearlyCaloriesBurned==0) {
        return progress = 0; // Reset progress if no intake or duration is found
      } else {
        // Calculate individual progress for yearly water intake and workout duration
       waterProgressYearly = totalYearlyWaterIntake / (totalYearlyWaterGoals*1000);
        workoutProgressYearly = (totalYearlyDurationWorkout/60) / _totalYearlyExerciseDurationGoals ;
        caloriesYealryProgress=totalYearlyCaloriesBurned/totalYearlyCalorieGoals;
       notifyListeners();
        // Calculate average progress
        progress = (waterProgressYearly!.clamp(0, 1)+ workoutProgressYearly!.clamp(0, 1)+caloriesYealryProgress!.clamp(0, 1)) *(1/3);
        return  progress = progress!.clamp(0, 1); // Ensure the value is between 0 and 1
      }
    } else {
      return progress = 0; // Reset progress if goals are not set
    }
    notifyListeners();   // Notify listeners to update UI
  }
}

