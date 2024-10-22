import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

  void addWater(int water) async {
    setState(() {
      totalWater += water;
      cupHeight = (totalWater / 1500) * 300; // Adjusted for full cup height
    });

    await _firestore.collection('waterIntake').add({
      'userId': widget.userId,
      'amount': totalWater,
      'timestamp': FieldValue.serverTimestamp(),
      // To record the time of addition
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar color
        title: const Text('💧 Water Tracker'),

      ),
      body: Center(
        child: Stack(

          alignment: Alignment.bottomCenter,
          // Align the water fill at the bottom
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              // Animation duration
              width: 150,
              // Set width to match the cup
              height: cupHeight,
              // Dynamically change height based on water consumed
              decoration: const BoxDecoration(
                color: Colors.lightBlue, // Water color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ), // Curved top edge to simulate water rising
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        overlayColor: const Color((0xFF004DFF)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: Colors.white),
        buttonSize: const Size(58, 58),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            elevation: 0,
            child: Image.asset('assets/cup.png'),
            labelWidget:
                const Text('150ml', style: TextStyle(color: Colors.blue)),
            backgroundColor: const Color(0xFFEBF2FD),
            onTap: () {
              addWater(150); // Add 150ml of water
            },
          ),
          SpeedDialChild(
            elevation: 0,
            child: Image.asset('assets/Bottele.png'),
            labelWidget:
                const Text('200ml', style: TextStyle(color: Colors.blue)),
            backgroundColor: const Color(0xFFEBF2FD),
            onTap: () {
              addWater(200); // Add 200ml of water
            },
          ),
          SpeedDialChild(
            elevation: 0,
            child: Image.asset('assets/500ml.png'),
            labelWidget:
                const Text('500ml', style: TextStyle(color: Colors.blue)),
            backgroundColor: const Color(0xFFEBF2FD),
            onTap: () {
              addWater(500); // Add 500ml of water
            },
          ),
        ],
      ),
    );
  }
}
