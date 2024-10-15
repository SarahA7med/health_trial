import 'package:flutter/material.dart';
import 'ExericiseLibrary.dart';

class workoutplan extends StatelessWidget {
  const workoutplan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      const Color(0xFFDBE4FF), // Light blue
      const Color(0xFF004DFF),
      const Color(0xFF759EFF), // Blue
      const Color(0xFFB1C8FF), // Light purple
    ];

    final List<String> categoriesUpper = ['FULL', 'UPPER', 'CORE', 'LOWER'];

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
            const SizedBox(
              height: 20,
            ),
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
                  itemCount: categoriesUpper.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseLibrary(selectedCategory: categoriesUpper[index]),
                          ),
                        );
                        print('${categoriesUpper[index]} tapped');
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
                                categoriesUpper[index],
                                style: TextStyle(
                                  color: (index == 0 || index == 3) ? Colors.black : Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'Body',
                                style: TextStyle(
                                  color: (index == 0 || index == 3) ? Colors.black : Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
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
