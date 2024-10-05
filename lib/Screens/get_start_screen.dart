import 'package:flutter/material.dart';
import 'package:health_trial/Screens/SignUp.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff004dff),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 20, right: 25, left: 30),
          child: Column(
            children: [
              const Image(
                image: AssetImage("assets/running-ezgif.com-speed.gif"),
                width: 300,
                height: 300,
              ),
              const Text(
                "You are ready to go!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),
              const   Center(
                child:  Text(
                  "Thanks for taking your time to create account with us.Now this is the fun part,",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal),
                ),
              ),
              const Center(
                child: Text(
                  "let's explore the app",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal),
                ),
              ),
              const Spacer(),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                },
                color: Colors.white,
                height: 80,
                minWidth: MediaQuery.of(context).size.width,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
