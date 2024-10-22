class WorkOutModel {
  final double calories_burned;
  final int duration;
  DateTime end_time;
  DateTime start_time;
final String user_id;
 WorkOutModel({
    required this.calories_burned,
    required this.duration,
    required this.end_time,
   required this.start_time,
   required this.user_id,
  });

  // transforme map or jison to object
  factory WorkOutModel.fromMap(Map<String, dynamic> map) {
    return WorkOutModel(
     calories_burned: map['calories_burned'] ?? 0.0,
     duration: map['duration'] ?? 0,
     end_time: map['end_time'] ?? 0,
     start_time: map['start_time'] ?? 0,
      user_id: map['user_id'] ?? 0,
    );
  }

  // transform data to map or jison to be able upload them
  Map<String, dynamic> toMap() {
    return {
      'calories_burned':   calories_burned,
      'duration':  duration,
      'end_time': end_time,
      'start_time':   start_time,
      'user_id': user_id,
    };
  }
}