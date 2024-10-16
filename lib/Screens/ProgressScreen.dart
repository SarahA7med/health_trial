import 'package:flutter/material.dart';
import 'package:health_trial/ViewModels/progress_viewmodel.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Progress();
  }
}

class _Progress extends State<Progress> {
  ProgressViewModel progressViewModel=ProgressViewModel();
  String userName="user";
  double progress = 0;
  Color selectedColor = const Color(0xFF004DFF);
  Color unselectedColor = const Color(0xFFB1C8FF); // لون غير محدد
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
   /* if (interval == 'Day') {
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
    }*/
    setState(() {}); // إعادة بناء الصفحة لعرض القيم الجديدة
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:const Text("✍Track you progress"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          ],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() async{
                        progress= await progressViewModel.calculateDailyProgress() as double;
                        upDataState("Day");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: day ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: day ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.all(5),
                      child: const Text(
                        'Day',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() async {
                        progress= await progressViewModel.calculateWeeklyProgress() as double;
                        upDataState("Week");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: week ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: week ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(right: 5),
                      child: const Text(
                        'Week',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() async {
                       progress= await ProgressViewModel().calculateManthlyProgress() as double;
                        upDataState('Month');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: month ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: month ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(right: 5),
                      child: const Text(
                        'Month',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() async {
                        progress= await progressViewModel.calculateYearlyProgress() as double;
                        upDataState('Year');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: year ? selectedColor : unselectedColor,
                        border: Border.all(
                            color: year ? selectedColor : unselectedColor,
                            width: 3),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(right: 5),
                      child: const Text(
                        'Year',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
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
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text('Workouts done: ${(progress*100).toInt()}/100', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            //Text(
              //'Great Job $userName',
              //style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
           // ),
          //  const Text('Successfully completed Day 4 of training',
              //  style: TextStyle(fontSize: 14)),
            const SizedBox(height: 50),
            // Weight Information (Three Boxes using GridView)
           /* Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: [
                  buildWeightBox('Target Weight', '$targetWeight kg',0),
                  buildWeightBox('Start Weight', '$startWeight kg',1),
                  buildWeightBox('Actual Weight', '$actualWeight kg',2),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }



  Widget buildWeightBox(String title, String value,int index) {
    List<Color> colors = [
      const Color(0xFF759EFF), // اللون الأول
      const Color(0xFFB1C8FF), // اللون الثاني
      const Color(0xFF004DFF), // اللون الثالث
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors[index % colors.length], // لون المربعات
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }}