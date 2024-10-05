import 'package:flutter/material.dart';
import 'package:health_trial/Screens/profile_picture.dart';


class GenderSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GenderSelectionState();
  }
}

class _GenderSelectionState extends State<GenderSelection> {
  Color _borderColorMan = Colors.transparent;
  Color _borderColorWoman = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
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
                    _borderColorMan = _borderColorMan == Colors.transparent
                        ? Colors.pinkAccent
                        : Colors.transparent;
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
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 5,
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(-5, 5),
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/woman.png",
                        fit: BoxFit.cover,
                        width: 155,
                        height: 200,
                      ),
                      //),
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
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _borderColorWoman = _borderColorWoman == Colors.transparent
                        ? Colors.blue
                        : Colors.transparent;
                    _borderColorMan = Colors.transparent;
                  });
                },
                child: Container(
                  width: 160,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: _borderColorWoman, width: 4.0),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
          Spacer(),
          Text(
            "To give you a customize",
            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          Text(
            "experience we need to know your gender",
            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfilePicture()));
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
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}