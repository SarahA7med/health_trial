import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Progress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Progress();
  }
}

class _Progress extends State<Progress> {
  String userName="user";
  double progress = 0;
  Color selectedColor = Color(0xFF004DFF);
  Color unselectedColor = Color(0xFFB1C8FF); // لون غير محدد
  bool day = false;
  double targetWeight = 0;
  double startWeight = 0;
  double actualWeight = 0;
  String? interval = ' ';
  bool month = false;
  bool week = false;
  bool year = false;
  int selectedIndex = 0;

  void upDataState(String interval1) {
    if (interval1 == "Day") {
      day = true;
      interval = 'Day';
      month = false;
      week = false;
      year = false;
    } else if (interval1 == "Week") {
      week = true;
      interval = "Week";
      day = false;
      month = false;
      year = false;
    } else if (interval1 == "Month") {
      interval = "Month";
      week = false;
      day = false;
      month = true;
      year = false;
    } else if (interval1 == "Year") {
      year = true;
      interval = "Year";
      day = false;
      month = false;
      week = false;
    }
    updateWeights();
  }

  void updateWeights() {
    // تحديث قيم الوزن بناءً على الاختيار
    if (interval == 'Day') {
      targetWeight = 70;
      startWeight = 75;
      actualWeight = 72;
      progress = 0.8; // قيمة التقدم لليوم
    } else if (interval == 'Week') {
      targetWeight = 68;
      startWeight = 75;
      actualWeight = 70;
      progress = 0.75; // قيمة التقدم للأسبوع
    } else if (interval == 'Month') {
      targetWeight = 65;
      startWeight = 75;
      actualWeight = 70;
      progress = 0.65; // قيمة التقدم للشهر
    } else if (interval == 'Year') {
      targetWeight = 60;
      startWeight = 75;
      actualWeight = 68;
      progress = 0.5; // قيمة التقدم للسنة
    } else {
      progress = 0;
    }
    setState(() {}); // إعادة بناء الصفحة لعرض القيم الجديدة
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:Text("✍️Track you progress"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          ],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        upDataState("Day");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: day ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: day ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.all(5),
                      child: Text(
                        'Day',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        upDataState("Week");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: week ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: week ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        'Week',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        upDataState('Month');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: month ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: month ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        'Month',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        upDataState('Year');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: year ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: year ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        'Year',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Circular Progress Chart
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(selectedColor),
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            Text('Workouts done: ${(progress*100).toInt()}/100', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              'Great Job $userName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Successfully completed Day 4 of training',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 50),
            // Weight Information (Three Boxes using GridView)
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: EdgeInsets.all(10),
                children: [
                  buildWeightBox('Target Weight', targetWeight.toString() + ' kg',0),
                  buildWeightBox('Start Weight', startWeight.toString() + ' kg',1),
                  buildWeightBox('Actual Weight', actualWeight.toString() + ' kg',2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget buildWeightBox(String title, String value,int index) {
    List<Color> colors = [
      Color(0xFF759EFF), // اللون الأول
      Color(0xFFB1C8FF), // اللون الثاني
      Color(0xFF004DFF), // اللون الثالث
    ];
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors[index % colors.length], // لون المربعات
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }}
