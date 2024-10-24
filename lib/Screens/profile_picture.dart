import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:health_trial/Screens/weight_hight.dart';

class ProfilePicture extends StatefulWidget {
  final String gender;
  final String name;
  final String email;
  const ProfilePicture(
      {super.key,
      required this.name,
      required this.email,
      required this.gender});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePictureState();
  }
}

class _ProfilePictureState extends State<ProfilePicture> {
  int _currentIndex = 0;
  int _currentAge = 18;

  final List<String> _imagePaths = [
    'assets/girl1.jpeg',
    'assets/girl2.jpeg',
    'assets/girl3.jpeg',
    'assets/boy3.jpeg',
    'assets/boy2.jpeg',
    'assets/boy1.jpeg',

  ];

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
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Profile Picture",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CarouselSlider.builder(
                    itemCount: _imagePaths.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.blueAccent
                                  : Colors.transparent,
                              width: 4,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(_imagePaths[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 120,
                          height: 120,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 120,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.3,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Select your profile picture.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: _imagePaths.length,
                    effect: const WormEffect(
                      activeDotColor: Colors.blueAccent,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      const Text(
                        "Select Your Age",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      NumberPicker(
                        value: _currentAge,
                        minValue: 18,
                        maxValue: 100,
                        itemHeight: 50,
                        axis: Axis.vertical,
                        onChanged: (value) =>
                            setState(() => _currentAge = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WeightHight(
                            name: widget.name,
                            email: widget.email,
                            gender: widget.gender,
                            profilePicture: _imagePaths[_currentIndex],
                            age: _currentAge,
                          ),
                        ),
                      );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
