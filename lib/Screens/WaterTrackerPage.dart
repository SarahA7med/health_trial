import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WaterTrackerPage extends StatefulWidget {
  final String? userId; // Pass the userId if needed

  const WaterTrackerPage({Key? key, this.userId}) : super(key: key);

  @override
  _WaterTrackerPageState createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int totalWater = 0; // Total water consumed in milliliters
  double cupHeight = 0; // Height of the water in the cup

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addWater() async {
    setState(() {
      totalWater += 150; // Add 150 ml to total water
      cupHeight = (totalWater / 1500) * 150; // Update the cup height based on total water
    });

    // Save the updated water intake to Firestore
    await _firestore.collection('waterIntake').add({
      'userId': widget.userId,
      'amount': 150,
      'timestamp': FieldValue.serverTimestamp(), // To record the time of addition
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar color
        title: const Text('💧 Water Tracker'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the total water consumed
            Text(
              'Total Water: $totalWater ml',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Water in the cup
            AnimatedContainer(
              duration: const Duration(milliseconds: 300), // Animation duration
              width: 100, // Adjusted for cup width
              height: cupHeight, // Update the height based on water consumed
              decoration: BoxDecoration(
                color: Colors.lightBlue, // Water color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Button to add water
            ElevatedButton(
              onPressed: addWater, // Add water when the button is pressed
              child: const Text('Add 150 ml'),
            ),
          ],
        ),
      ),
    );
  }
}
