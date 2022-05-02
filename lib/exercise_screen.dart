import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:the_exercise_project/exercise_details.dart';

import 'package:the_exercise_project/global_data.dart' as global;

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreen();
}

class _ExerciseScreen extends State<ExerciseScreen> {
  CarouselController carouselController = CarouselController();

  int repCountValue = 0;
  bool nextExerciseVisibility = true;
  bool previousExerciseVisibility = false;
  int exerciseIndex = 1;
  String nextExerciseName = "";
  String previousExerciseName = "";

  void test() {}

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
        opacity: animation,
        child: new ExerciseDetailsScreen(
          index: exerciseIndex - 1,
        ));
  }

  void recordReps() {
    showModalBottomSheet<void>(
        context: context,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment(0, -1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "How many repetitions did you do?",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0),
                    child: NumberPicker(
                      value: repCountValue,
                      minValue: 0,
                      maxValue: 300,
                      itemHeight: 200,
                      textStyle: TextStyle(fontSize: 20),
                      selectedTextStyle: TextStyle(fontSize: 50),
                      axis: Axis.horizontal,
                      haptics: true,
                      onChanged: (int value) {
                        setModalState(() {
                          repCountValue = value;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.95),
                    child: SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: recordReps,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(5),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Complete',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget getExerciseCard(int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExerciseDetailsScreen(
                        index: index,
                      )),
            );
          },
          child: Stack(
            children: [
              Hero(
                tag: 'exerciseImage' + index.toString(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(global.exercisesImages[index])),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromARGB(140, 0, 0, 0),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            global.exerciseNames[index],
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 40,
                            endIndent: 40,
                            color: Colors.grey,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "15",
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const Text(
                                "Repetitions",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, 0.9),
          child: SizedBox(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
              onPressed: recordReps,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: const Text(
                'Record',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void carouselPageChanged(int index) {
    setState(() {
      exerciseIndex = index + 1;

      index == 0
          ? previousExerciseVisibility = false
          : previousExerciseVisibility = true;
      index == global.exerciseNames.length - 1
          ? nextExerciseVisibility = false
          : nextExerciseVisibility = true;

      index == 0
          ? previousExerciseName = ""
          : previousExerciseName = global.exerciseNames[index - 1];
      index == global.exerciseNames.length - 1
          ? nextExerciseName = ""
          : nextExerciseName = global.exerciseNames[index + 1];
    });
  }

  void nextExercise() {
    carouselController.nextPage(curve: Curves.easeInOutCubic);
  }

  void previousExercise() {
    carouselController.previousPage(curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Color.fromARGB(255, 251, 215, 191),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    previousExerciseVisibility
                        ? TextButton(
                            onPressed: previousExercise,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.chevron_left,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Previous",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      previousExerciseName,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Text(""),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          exerciseIndex.toString(),
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "of 12",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    nextExerciseVisibility
                        ? TextButton(
                            onPressed: nextExercise,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Next",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      nextExerciseName,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                Icon(Icons.chevron_right,
                                    size: 40, color: Colors.black),
                              ],
                            ),
                          )
                        : Text(""),
                  ],
                ),
              ),
            ),
          ),
          CarouselSlider.builder(
            itemCount: global.exerciseNames.length,
            carouselController: carouselController,
            itemBuilder: (context, index, realIndex) {
              return getExerciseCard(index);
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) => carouselPageChanged(index),
              height: MediaQuery.of(context).size.height * 0.8,
              enlargeCenterPage: true,
            ),
          ),
        ],
      ),
    );
  }
}
