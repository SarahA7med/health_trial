import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/Screens/gender_selection.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Padding from the top
            Text(
              isLogin ? 'Login' : 'Sign Up',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004DFF),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Toggle between Login and Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = true; // Switch to Login
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: isLogin ? Color(0xFF004DFF) : Colors.grey[600],
                      fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = false; // Switch to Sign Up
                    });
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: !isLogin ? Color(0xFF004DFF) : Colors.grey[600],
                      fontWeight: !isLogin ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/your_image.png', // Add your image path here
              width: 250,
              height: 250,),
            SizedBox(
              height: 10,
            ),
            isLogin ? buildLoginForm() : buildSignUpForm(), // Form based on state

          ],
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              suffixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: Icon(Icons.visibility),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF004DFF),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GenderSelection()
              ));
            },
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
             suffixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              suffixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: Icon(Icons.visibility),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF004DFF),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GenderSelection()
              ));
              // Handle sign-up logic
            },
            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}

