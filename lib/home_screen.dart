import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'exercise_catalog.dart';
import 'exercise_screen.dart';

import 'global_data.dart' as global;
import 'breathing_exercise_screen.dart';
import 'outdoor_exercise_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  void test() {}

  String generateGreeting() {
    return global.dailyGreeting[DateTime.now().weekday] +
        " " +
        global.dayOfWeek[DateTime.now().weekday];
  }

  void goToOutdoorExerciseScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OutdoorExerciseScreen()),
    );
  }

  void goToExerciseScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExerciseScreen()),
    );
  }

  void goToMeditationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BreathingExerciseScreen()),
    );
  }

  void goToExerciseCatalog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExerciseCatalog()),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      title: Text(
        "The Exercise Project",
        style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato'),
      ),
      centerTitle: true,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
    );
  }

  Widget getBottomBar() {
    return BottomAppBar(
      elevation: 10,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
        ),
      ),
      child: Container(
        height: 63,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: test,
                child: Column(
                  children: [
                    Icon(
                      Icons.list_alt_rounded,
                      size: 30,
                    ),
                    Text("Logs"),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 60,
                child: ElevatedButton(
                  onPressed: test,
                  child: Icon(Icons.home_rounded),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(5),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: test,
                child: Column(
                  children: [
                    Icon(
                      Icons.flag_rounded,
                      size: 30,
                    ),
                    Text("Goals"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getGreetingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Text(
              "have a " + generateGreeting() + ", ",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/ExercisePics/Pullups.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                ),
                Text(
                  "Yuvjeeth",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getWeekLog() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int index = 0; index < global.dayOfWeek.length; index++)
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: test,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(
                        global.dayOfWeek[index].substring(0, 3),
                        style: TextStyle(
                            fontSize: 12,
                            color: index == DateTime.now().weekday
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black54),
                      ),
                      Text(
                        DateTime.now()
                            .add(Duration(days: index - DateTime.now().weekday))
                            .day
                            .toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: index == DateTime.now().weekday
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget getStatsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Today's Exercise Stats",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWorkoutTiles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Workouts for you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/UI Elements/Outdoor_Exercise_BG.jpg'),
                            fit: BoxFit.fitWidth,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken)),
                      ),
                      child: Align(
                        alignment: Alignment(-0.8, 0),
                        child: Text(
                          "Go outdoors",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: goToOutdoorExerciseScreen,
                        borderRadius: BorderRadius.circular(18),
                        highlightColor: Colors.black.withOpacity(0.2),
                        splashColor: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/UI Elements/Home_Workout_BG.jpg'),
                            fit: BoxFit.fitWidth,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken)),
                      ),
                      child: Align(
                        alignment: Alignment(-0.8, 0),
                        child: Text(
                          "Workout at home",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: goToExerciseScreen,
                        borderRadius: BorderRadius.circular(18),
                        highlightColor: Colors.black.withOpacity(0.2),
                        splashColor: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/UI Elements/Meditate_BG.jpg'),
                            fit: BoxFit.fitWidth,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken)),
                      ),
                      child: Align(
                        alignment: Alignment(-0.8, 0),
                        child: Text(
                          "Enhance your breathing",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: goToMeditationScreen,
                        borderRadius: BorderRadius.circular(18),
                        highlightColor: Colors.black.withOpacity(0.2),
                        splashColor: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/UI Elements/CustomExercise_BG.jpg'),
                            fit: BoxFit.fitWidth,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken)),
                      ),
                      child: Align(
                        alignment: Alignment(-0.8, 0),
                        child: Text(
                          "All exercises",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: goToExerciseCatalog,
                        borderRadius: BorderRadius.circular(18),
                        highlightColor: Colors.black.withOpacity(0.2),
                        splashColor: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: getBottomBar(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getGreetingSection(),
                  getWeekLog(),
                  getStatsCard(),
                  getWorkoutTiles(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
