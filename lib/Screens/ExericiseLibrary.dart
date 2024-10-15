import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_trial/exercise.dart'; // تأكد من استيراد النموذج

class ExerciseLibrary extends StatefulWidget {
  final String selectedCategory;

  ExerciseLibrary({super.key, required this.selectedCategory});

  @override
  _ExerciseLibraryState createState() => _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  List<Exercise> exercises = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    final response = await http.get(
      Uri.parse('https://exercisedb.p.rapidapi.com/exercises'),
      headers: {
        'X-RapidAPI-Key': '25862de7b4msh50339ae9b12035fp170d6ajsn33161befa41a', // استبدل بمفتاح API الخاص بك
        'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        exercises = jsonResponse.map((exercise) {
          return Exercise.fromJson({
            'name': exercise['name'],
            'duration': getDurationForExercise(exercise['name']),
            'calories': calculateCalories(exercise['name']),
          });
        }).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  String getDurationForExercise(String exerciseName) {
    // استخدم معلومات دقيقة عن المدة هنا
    if (exerciseName == '3/4 sit-up') {
      return '30 seconds';
    } else if (exerciseName == '45° side bend') {
      return '45 seconds';
    }
    return 'N/A';
  }

  String calculateCalories(String exerciseName) {
    // استخدم معلومات دقيقة عن السعرات الحرارية هنا
    if (exerciseName == '3/4 sit-up') {
      return '15 calories';
    } else if (exerciseName == '45° side bend') {
      return '20 calories';
    }
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Library'),
      ),
      body: Container(
        color: Colors.white,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : exercises.isEmpty
            ? Center(child: Text('No exercises found.'))
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return exerciseCard(exercise);
          },
        ),
      ),
    );
  }

  Widget exerciseCard(Exercise exercise) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                exercise.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${exercise.duration} • ${exercise.calories}',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Starting Workout'),
                          content: Text('You are starting: ${exercise.title}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
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
