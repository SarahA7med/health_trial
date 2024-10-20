class WorkOutModel {
  final double calories_burned;
  final double duration;
  DateTime end_time;
  DateTime start_time;
final int steps;
 WorkOutModel({
    required this.calories_burned,
    required this.duration,
    required this.end_time,
   required this.start_time,
   required this.steps,
  });

  // transforme map or jison to object
  factory WorkOutModel.fromMap(Map<String, dynamic> map) {
    return WorkOutModel(
     calories_burned: map['calories_burned'] ?? 0,
     duration: map['duration'] ?? 0,
     end_time: map['end_time'] ?? 0,
     start_time: map['start_time'] ?? 0,
     steps: map['steps'] ?? 0,
    );
  }

  // transform data to map or jison to be able upload them
  Map<String, dynamic> toMap() {
    return {
      'calories_burned':   calories_burned,
      'duration':  duration,
      'end_time': end_time,
      'start_time':   start_time,
      'steps': steps,
    };
  }
}