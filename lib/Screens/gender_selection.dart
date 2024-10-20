import 'package:flutter/material.dart';
import 'package:health_trial/Screens/profile_picture.dart';

class GenderSelection extends StatefulWidget {
  final String name;
  final String email;
  const GenderSelection({super.key, required this.name, required this.email});

  @override
  State<StatefulWidget> createState() {
    return _GenderSelectionState();
  }
}

class _GenderSelectionState extends State<GenderSelection> {
  String selectedGender = '';

  Color _borderColorMan = Colors.transparent;
  Color _borderColorWoman = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const SizedBox(height: 20),
          const Text(
            "What's your gender?",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Color(0xff1E1E1E),
            ),
          ),
          const SizedBox(height: 65),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = 'Female';
                    _borderColorMan = Colors.pinkAccent;
                    _borderColorWoman = Colors.transparent;
                  });
                },
                child: Container(
                  width: 160,
                  height: 250,
                  decoration: BoxDecoration(
                      border: Border.all(color: _borderColorMan, width: 4),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            spreadRadius: 5,
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(-5, 5),
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/woman.png",
                        fit: BoxFit.cover,
                        width: 155,
                        height: 200,
                      ),
                      const Text(
                        "Female",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = 'Male';
                    _borderColorWoman = Colors.blue;
                    _borderColorMan = Colors.transparent;
                  });
                },
                child: Container(
                  width: 160,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: _borderColorWoman, width: 4.0),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 5,
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(-5, 5),
                          blurStyle: BlurStyle.outer)
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/man.png",
                        fit: BoxFit.cover,
                        width: 155,
                        height: 200,
                      ),
                      const Text(
                        "Male",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (selectedGender.isEmpty) {
                // Show a SnackBar if no gender is selected
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Please select a gender',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                // Navigate to the next screen if a gender is selected
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePicture(
                      name: widget.name,
                      email: widget.email,
                      gender: selectedGender,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff004DFF),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
