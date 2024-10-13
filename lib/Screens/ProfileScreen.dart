import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {

  User? user =  FirebaseAuth.instance.currentUser;
  final String name=;
  final String photoUrl;
  final int totalWorkoutHours;
  final int age;
  final String email;
  final double height; // Height in cm
  final double weight; // Weight in kg
  final double workoutGoalHours; // Goal for workout hours


  //  ProfileWidget({
  //   super.key,
  //   required this.name,
  //   required this.photoUrl,
  //   required this.totalWorkoutHours,
  //   required this.age,
  //   required this.email,
  //   required this.height,
  //   required this.weight,
  //   required this.workoutGoalHours,
  // });

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    double workoutProgress = widget.totalWorkoutHours / widget.workoutGoalHours;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildBody(context, workoutProgress),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade400, Colors.blue.shade800],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 47,
                backgroundImage: NetworkImage(widget.photoUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, double workoutProgress) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Workout Progress'),
          const SizedBox(height: 10),
          _buildProgressBar(context, workoutProgress, widget.totalWorkoutHours, widget.workoutGoalHours),
          const SizedBox(height: 20),
          _buildSectionTitle('Personal Information'),
          const SizedBox(height: 10),
          _buildInfoGrid(),
          const SizedBox(height: 20),
          _buildSectionTitle('Fitness Goals'),
          const SizedBox(height: 10),
          _buildGoalsSection(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, double progress, int current, double goal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 15,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1 ? Colors.green : Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "$current / ${goal.toStringAsFixed(0)} hours",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: progress >= 1 ? Colors.green : Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        _buildInfoItem(Icons.fitness_center, 'Workout Hours', '${widget.totalWorkoutHours} h'),
        _buildInfoItem(Icons.cake, 'Age', '${widget.age} years'),
        _buildInfoItem(Icons.height, 'Height', '${widget.height.toStringAsFixed(1)} cm'),
        _buildInfoItem(Icons.monitor_weight, 'Weight', '${widget.weight.toStringAsFixed(1)} kg'),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Keep pushing! You're ${widget.totalWorkoutHours < widget.workoutGoalHours ? 'almost' : 'over'} your goal.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Next goal: ${widget.workoutGoalHours + 10} hours",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
