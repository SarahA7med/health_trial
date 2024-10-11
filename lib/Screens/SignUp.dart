
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/Screens/HomeScreen.dart';
import 'package:health_trial/Screens/gender_selection.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Padding from the top
            Text(
              isLogin ? 'Login' : 'Sign Up',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004DFF),
              ),
            ),
            const SizedBox(
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
                      color:
                          isLogin ? const Color(0xFF004DFF) : Colors.grey[600],
                      fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = false; // Switch to Sign Up
                    });
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color:
                          !isLogin ? const Color(0xFF004DFF) : Colors.grey[600],
                      fontWeight:
                          !isLogin ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Image.asset(
              'assets/your_image.png', // Add your image path here
              width: 250,
              height: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            isLogin ? buildLoginForm() : buildSignUpForm(),
            // Form based on state
          ],
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: loginFormKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'this field is required';
                  } else {
                    return null;
                  }
                },
                controller: loginEmailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  suffixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'this field is required';
                  } else {
                    return null;
                  }
                },
                controller: loginPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: const Icon(Icons.visibility),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004DFF),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () async {
                  if (loginFormKey.currentState!.validate()) {
                    try {
                      UserCredential user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: loginEmailController.text,
                              password: loginPasswordController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'Welcome to Health Trial',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Homescreen()));
                      });
                    } on FirebaseAuthException catch (e) {
                      String message;
                      if (e.code == 'user-not-found') {
                        message = 'No user found for that email.';
                      } else if (e.code == 'wrong-password') {
                        message = 'Wrong password provided for that user.';
                      } else {
                        message = 'Enter valid data.';
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(message,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600  ,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      );
                      print(e.toString());
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(e.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      );
                      print(e.toString());
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(e.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      );
                      print(e.toString());
                    }
                  }

                  // Handle sign-up logic
                },
                child: const Center(
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
          ),
        ));
  }

  Widget buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: signupFormKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'this field is required';
                } else {
                  return null;
                }
              },
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                suffixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'this field is required';
                } else {
                  return null;
                }
              },
              controller: signupEmailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                suffixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'this field is required';
                } else {
                  return null;
                }
              },
              controller: signupPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: const Icon(Icons.visibility),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004DFF),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () async {
                if (signupFormKey.currentState!.validate()) {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: signupEmailController.text,
                      password: signupPasswordController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text('Welcome to Health Trial',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GenderSelection()));
                    });
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(e.message.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    );
                    print(e.toString());
                  } on Exception catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(e.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    );
                    print(e.toString());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(e.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    );
                    print(e.toString());
                  }
                }

                // Handle sign-up logic
              },
              child: const Center(
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
      ),
    );
  }
}
