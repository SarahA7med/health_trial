import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'WaterTrackerPage.dart';
import 'walking_tracker_page.dart'; // Import the WalkingTrackerPage

class WorkoutPlan extends StatelessWidget {
  const WorkoutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      const Color(0xFFDBE4FF), // Light blue
      const Color(0xFF004DFF), // Blue
      const Color(0xFF759EFF), // Blue
      const Color(0xFFB1C8FF), // Light purple
    ];

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final List<String> categories = ['Track Walking', 'Running', 'Cardio', 'Water'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('💪Workout Plan'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (categories[index] == 'Track Walking') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WalkingTrackerPage(userId: uid), // Navigate to walking tracker page
                            ),
                          );
                        } else if (categories[index] == 'Water') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WaterTrackerPage(userId: uid), // Navigate to water tracker page
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                categories[index],
                                style: TextStyle(
                                  color: (index == 0 || index == 3) ? Colors.black : Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
