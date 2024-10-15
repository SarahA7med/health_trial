class Exercise {
  final String title;
  final String duration; // مدة التمرين
  final String calories; // السعرات الحرارية

  Exercise({
    required this.title,
    required this.duration,
    required this.calories,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      title: json['name'] ?? 'Unknown Exercise',
      duration: json['duration'] ?? 'N/A',
      calories: json['calories'] ?? 'N/A',
    );
  }
}
