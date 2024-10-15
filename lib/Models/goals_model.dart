class GoalsModel {
  final int waterGoal; //  رتليللملاب ءاملا ةيمك
  final int caloriesGoal; //  ةقورحملا ةيرارحلا تارعسلا
  final int exerciseDurationGoal; //  قئاقدلاب نيرمتلا ةدم

  GoalsModel({
    required this.waterGoal,
    required this.caloriesGoal,
    required this.exerciseDurationGoal,
  });

  // نم ليوحت Map  جذومن ىلإ ( نم بلجلا دنع Firestore ىرخأ تانايب ةدعاق وأ)
  factory GoalsModel.fromMap(Map<String, dynamic> map) {
    return GoalsModel(
      waterGoal: map['waterGoal'] ?? 0,
      caloriesGoal: map['caloriesGoal'] ?? 0,
      exerciseDurationGoal: map['exerciseDurationGoal'] ?? 0,
    );
  }

  // ىلإ جذومنلا ليوحت Map ( يف نيزختلل Firestore ىرخأ تانايب ةدعاق وأ)
  Map<String, dynamic> toMap() {
    return {
      'waterGoal': waterGoal,
      'caloriesGoal': caloriesGoal,
      'exerciseDurationGoal': exerciseDurationGoal,
    };
  }
}