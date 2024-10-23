import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_trial/ViewModels/progress_viewmodel.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<StatefulWidget> createState() {

    return _Progress();
  }
}

class _Progress extends State<Progress> {

  //ProgressViewModel progressViewModel=ProgressViewModel();
  String userName="user";
  double progress = 0;
  Color selectedColor = const Color(0xFF004DFF);
  Color unselectedColor = const Color(0xFFB1C8FF);
  bool day = false;
  double targetWeight = 0;
  double startWeight = 0;
  double actualWeight = 0;
  String? interval = ' ';
  bool month = false;
  bool week = false;
  bool year = false;
  int selectedIndex = 0;
  double?waterProgress=0;
  double?caloriesProgress=0;
  double?durationProgress=0;

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
    //updateWeights();
  }
  @override
  void initState() {
    super.initState();
    updateProgress("Day");
    updateProgress("Week");
    updateProgress("Month");
    updateProgress("Year");
  }
  void updateProgress(String intervalType) async {
    double calculatedProgress;
    if (intervalType == "Day") {
      calculatedProgress =
      await Provider.of<ProgressViewModel>(context, listen: false)
          .calculateDailyProgress();
    } else if (intervalType == "Week") {
      calculatedProgress =
      await Provider.of<ProgressViewModel>(context, listen: false)
          .calculateWeeklyProgress();
    } else if (intervalType == "Month") {
      calculatedProgress =
      await Provider.of<ProgressViewModel>(context, listen: false)
          .calculateMonthlyProgress();
    } else {
      calculatedProgress =
      await Provider.of<ProgressViewModel>(context, listen: false)
          .calculateYearlyProgress();
    }

    setState(() {
      progress = calculatedProgress;
      upDataState(intervalType);
    });
  }
void upDateProgressDetails(String determine)async{
    switch(determine){
      case 'Day':{
       waterProgress=await Provider.of<ProgressViewModel>(context, listen: false).waterProgressDaily;
       durationProgress=await Provider.of<ProgressViewModel>(context, listen: false).workoutProgressDaily;
       caloriesProgress=await Provider.of<ProgressViewModel>(context, listen: false).caloriesProgressDaily;
       if(waterProgress!>=1) {
         waterProgress = 1;
       }
       if(durationProgress!>=1){
         durationProgress=1;
       }
       if(caloriesProgress!>=1){
         caloriesProgress==1;
       }
        break;
      }
      case 'Week':{
      waterProgress=await Provider.of<ProgressViewModel>(context, listen: false).waterProgressWeekly;
       durationProgress=await Provider.of<ProgressViewModel>(context, listen: false).workoutProgressWeekly;
       caloriesProgress=await Provider.of<ProgressViewModel>(context, listen: false).caloriesWeeklyProgress;
      if(waterProgress!>=1) {
        waterProgress = 1;
      }
      if(durationProgress!>=1){
        durationProgress=1;
      }
      if(caloriesProgress!>=1){
        caloriesProgress==1;
      }
        break;
      }
      case 'Month':{
       waterProgress=await Provider.of<ProgressViewModel>(context, listen: false).waterProgressMontly;
       durationProgress=await Provider.of<ProgressViewModel>(context, listen: false).workoutProgressMonthly;
       caloriesProgress=await Provider.of<ProgressViewModel>(context, listen: false).caloriesManthlyProgress;
        break;
      }
    case 'Year':{
  waterProgress=await Provider.of<ProgressViewModel>(context, listen: false).waterProgressYearly;
 durationProgress=await Provider.of<ProgressViewModel>(context, listen: false).workoutProgressYearly;
caloriesProgress=await Provider.of<ProgressViewModel>(context, listen: false).caloriesYealryProgress;
  if(waterProgress!>=1) {
    waterProgress = 1;
  }
  if(durationProgress!>=1){
    durationProgress=1;
  }
  if(caloriesProgress!>=1){
    caloriesProgress==1;
  }
  break;
  }

}}




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
                      setState(() {
                        updateProgress('Day');
                        upDateProgressDetails('Day');
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
                      setState(() {
                        updateProgress('Week');
                        upDateProgressDetails('Week');
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
                      setState(() {
                        updateProgress('Month');
                        upDateProgressDetails('Month');

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
                      setState(() {
                        updateProgress('Year');
                        upDateProgressDetails('Year');
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

            Text('Total Progress: ${(progress*100).toInt()}/100', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value:caloriesProgress , // Change this to the specific progress value for each chart
                          strokeWidth: 12,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(selectedColor),
                        ),
                      ),
                      Text(
                        'calories progress  ${(caloriesProgress! * 100).toInt()}%',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: durationProgress, // Change this to the specific progress value for each chart
                          strokeWidth: 12,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(selectedColor),
                        ),
                      ),
                      Text(
                        'duration progress ${(durationProgress! * 100).toInt()}%',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: waterProgress, // Change this to the specific progress value for each chart
                          strokeWidth: 12,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(selectedColor),
                        ),
                      ),
                      Text(
                        'water progress ${(waterProgress! * 100).toInt()}%',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}