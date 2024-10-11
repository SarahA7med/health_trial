import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'HomeScreen.dart';
import 'ProfileScreen.dart';
import 'ProgressScreen.dart';
import 'workoutplan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
final _items=[
  SalomonBottomBarItem(icon: const Icon(Icons.home), title:Text('Home')),
  SalomonBottomBarItem(icon: const Icon(Icons.fitness_center), title:Text('Activity')),
  SalomonBottomBarItem(icon: const Icon(Icons.show_chart), title:Text('Progress')),
  SalomonBottomBarItem(icon: const Icon(Icons.person), title:Text('Profile'))
];
  final List<Widget> _screens = [
    Homescreen(),
    workoutplan(), // Ensure this class is named correctly
    Progress(), // Ensure this class is named correctly
    const ProfileWidget(email: 'sara@example.com', name: 'Sarah', photoUrl: 'assets/woman.png', totalWorkoutHours: 20, age: 22, height: 167, weight: 54, workoutGoalHours: 50,), // Ensure this class is named correctly
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar:
      SalomonBottomBar(
        backgroundColor: Colors.white,
        items:_items,
        selectedItemColor: const Color(0xFF004DFF),
        unselectedItemColor: const Color(0xFF759EFF),
        currentIndex:_selectedIndex ,
      onTap: (index)=> setState(() {
        _selectedIndex = index;
      }),) ,
    );
  }
}
