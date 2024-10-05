import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ExericiseLibrary.dart';

class workoutplan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Colors for each block
    final List<Color> colors = [
      Color(0xFFDBE4FF),  // Light blue
      Color(0xFF004DFF),
      Color(0xFF759EFF),// Blue
      Color(0xFFB1C8FF),  // Light purple
       // Medium blue
    ];

    // Categories text
    final List<String> categoriesUpper = [
      'FULL', 'UPPER', 'CORE', 'LOWER'
    ];

    final List<String> categoriesLower = [
      'Body', 'Body', 'Body', 'Body'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('💪Workout Plan'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color:Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,  // 2 columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.7,  // Decreased aspect ratio for bigger blocks
                  ),
                  itemCount: categoriesUpper.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExerciseLibrary()),
                        );
                        print('${categoriesUpper[index]} tapped');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],  // Assign each block a color
                          borderRadius: BorderRadius.circular(15.0),  // Rounded corners
                        ),
                    child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(
                    categoriesUpper[index],
                    style: TextStyle(
                    color: (index == 0 || index == 3)
                    ? Colors.black
                        : Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    ),
                    ),
                    Text(
                    categoriesLower[index],
                    style: TextStyle(
                    color: (index == 0 || index == 3)
                    ? Colors.black
                        : Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    ),
                    )]
                    ))));

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
