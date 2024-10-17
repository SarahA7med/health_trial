class GoalsModel {
  final double waterGoal;
  final int caloriesGoal;
  final int exerciseDurationGoal;

  GoalsModel({
    required this.waterGoal,
    required this.caloriesGoal,
    required this.exerciseDurationGoal,
  });

  // transforme map or jison to object
  factory GoalsModel.fromMap(Map<String, dynamic> map) {
    return GoalsModel(
      waterGoal: map['waterGoal'] ?? 0,
      caloriesGoal: map['caloriesGoal'] ?? 0,
      exerciseDurationGoal: map['exerciseDurationGoal'] ?? 0,
    );
  }

  // transform data to map or jison to be able upload them
  Map<String, dynamic> toMap() {
    return {
      'waterGoal': waterGoal,
      'caloriesGoal': caloriesGoal,
      'exerciseDurationGoal': exerciseDurationGoal,
    };
  }
}