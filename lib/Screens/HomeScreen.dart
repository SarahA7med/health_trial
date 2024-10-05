import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white, // Background color
        body: SingleChildScrollView(
        // Enables scrolling if content overflows
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const SizedBox(height: 50),
    // Greeting Section
    const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    Image(
    image: AssetImage("assets/waving-hand.png"),
    height: 50,
    width: 50,
    ),
    Text(
    "Hello, Max",
    style: TextStyle(
    fontSize: 24,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    SizedBox(height: 8),
    Text(
    "Let's have a productive workout today!",
    style: TextStyle(
    fontSize: 16,
    color: Colors.grey,
    ),
    ),
    ],
    ),
    // Profile/Settings Icon
    Icon(Icons.add_alert_sharp, size: 30, color: Colors.grey),
    ],
    ),
    const SizedBox(height: 20),

    // Today's Workout Section
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF004dff),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    child: const Text(
    "Advanced",
    style: TextStyle(color: Colors.white),
    ),
    ),
    ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xff759eff),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    child: const Text(
    "5 training days",
    style: TextStyle(color: Colors.white),
    ),
    ),
    ],
    ),
    const SizedBox(height: 20),

    // Daily Challenge Section
    Card(
    color: const Color(0xFF004dff), // Blue background
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
    ),
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
    "Daily Challenge",
    style: TextStyle(
    fontSize: 18,
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 15),
    Text(
    "Full Body Strength",
    style: TextStyle(
    fontSize: 16,
    color: Colors.white.withOpacity(0.9),
    ),
    ),
    const SizedBox(height: 10),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "Time: 45 minutes",
    style: TextStyle(
    fontSize: 10,
    color: Colors.white70,
    ),
    ),
    Text(
    "SQUATS, PUSH-UPS",
    style: TextStyle(
    fontSize: 10,
    color: Colors.white70,
    ),
    ),
    ],
    ),
    ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
    ),
    ),
    child: const Text(
    "Start",
    style: TextStyle(color: Colors.white),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ),
    const SizedBox(height: 20),

    // Daily Progress Section
    Card(
    color: const Color(0xff759eff),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
    ),
    elevation: 4,
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
    "Daily Progress",
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 10),
    ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: const LinearProgressIndicator(
    value: 0.6,
    // Set your daily progress here (60% in this case)
    backgroundColor: Color(0xff759eff),
    valueColor:
    AlwaysStoppedAnimation<Color>(Color(0xFF004dff)),
    ),
    ),
    const SizedBox(height: 10),
    const Text(
    "60% completed today",
    style: TextStyle(fontSize: 16),
    ),
    ],
    ),
    ),
    ),
    const SizedBox(height: 20),

    // Recommended Tasks Section (Similar Cards)
    Card(
    color: const Color(0xffDBe4ff),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
    ),
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "Cardio Blast",
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 20),
    Text(
    "Time: 45 minutes",
    style: TextStyle(
    fontSize: 10,
    color: Colors.black,
    ),
    ),
    Text(
    "SQUATS, PUSH-UPS",
    style: TextStyle(
    fontSize: 10,
    color: Colors.black,
    ),
    ),
    ],
    ),
    ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
    ),
    ),
    child: const Text(
    "Start",
    style: TextStyle(color: Colors.white),
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    )
    );

  }
}
