import 'package:flutter/material.dart';

import 'get_start_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff004dff),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 20),
          child: Column(
            children: [
              const Image(
                image: AssetImage("assets/dumbbell-ezgif.com-gif-maker.gif"),
                width: 300,
                height: 300,
              ),
              const Text(
                "Health Trail",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Home",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GetStartScreen()),
                    );
                  },
                  color: Colors.white,
                  height: 80,
                  minWidth: MediaQuery.of(context).size.width,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Start",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
