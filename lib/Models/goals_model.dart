class GoalsModel {
  final double waterGoal;
  final int caloriesGoal;
  final int exerciseDurationGoal;
  String date;
  GoalsModel({
    required this.waterGoal,
    required this.caloriesGoal,
    required this.exerciseDurationGoal,
    required this.date,
  });

  // transforme map or jison to object
  factory GoalsModel.fromMap(Map<String, dynamic> map) {
    return GoalsModel(

      caloriesGoal: map['caloriesGoal'] ?? 0,

      date: map['date'] ?? 0,

      exerciseDurationGoal: map['exerciseDurationGoal'] ?? 0,
      waterGoal: map['waterGoal'] ?? 0,
    );
  }

  // transform data to map or jison to be able upload them
  Map<String, dynamic> toMap() {
    return {
      'waterGoal': waterGoal,
      'caloriesGoal': caloriesGoal,
      'exerciseDurationGoal': exerciseDurationGoal,
      'date':date
    };
  }
}