import 'package:flutter/material.dart';

class ExerciseLibrary extends StatelessWidget {
  // Define a list of colors
  final List<Color> exerciseColors = [
    Color(0xFF004DFF),
    Color(0xFFDBE4FF), // Light blue
    Color(0xFF759EFF), // Blue
    Color(0xFFB1C8FF), // Light blue
  ];

  // Sample exercises (replace this with API call in your app)
  final List<Map<String, String>> exercises = [
    {'title': 'Bicep Curls', 'duration': '25 min', 'calories': '30 kcal'},
    {
      'title': 'Shoulder Press',
      'duration': '10-15 min',
      'calories': '20-30 kcal'
    },
    {'title': 'Push-ups', 'duration': '25 min', 'calories': '25 kcal'},
    {'title': 'Squats', 'duration': '30 min', 'calories': '40 kcal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Library'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  // Get exercise details
                  final exercise = exercises[index];
                  // Get color based on index
                  final color = exerciseColors[index % exerciseColors.length];

                  final textColor = (index % 2 == 0) ? Colors.white : Colors
                      .black;

                  return exerciseCard(
                    exercise['title']!,
                    exercise['duration']!,
                    exercise['calories']!,
                    color,
                    textColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget exerciseCard(String title, String duration, String calories, Color color, Color textColor) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: color,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Adjusted padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // This will allow the card to shrink if needed
            children: [
              // Title
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20, // Adjusted font size to fit within space
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8), // Space between title and subtitle

              // Subtitle with duration and calories
              Text(
                '$duration • $calories',
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontSize: 16, // Adjusted font size
                ),
              ),
              SizedBox(height: 8), // Space between subtitle and button

              // Button at the bottom right
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text(
                    'Start Workout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
