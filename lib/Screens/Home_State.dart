import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'HomeScreen.dart';
import 'ProfileScreen.dart';
import 'ProgressScreen.dart';
import 'workoutplan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
final _items=[
  SalomonBottomBarItem(icon: const Icon(Icons.home), title:const Text('Home')),
  SalomonBottomBarItem(icon: const Icon(Icons.fitness_center), title:const Text('Activity')),
  SalomonBottomBarItem(icon: const Icon(Icons.show_chart), title:const Text('Progress')),
  SalomonBottomBarItem(icon: const Icon(Icons.person), title:const Text('Profile'))
];
  final List<Widget> _screens = [
    const Homescreen(),
    const workoutplan(), // Ensure this class is named correctly
    const Progress(), // Ensure this class is named correctly
    const ProfileWidget( ), // Ensure this class is named correctly
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
