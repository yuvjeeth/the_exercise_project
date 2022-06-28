import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:the_exercise_project/models/exercise.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:the_exercise_project/global_data.dart' as global;

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({Key? key, required this.exerciseName})
      : super(key: key);

  final String exerciseName;

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreen();
}

class _ExerciseDetailsScreen extends State<ExerciseDetailsScreen> {
  int exerciseIndex = -1;
  int repCountValue = 0;

  void test() {}

  @override
  void initState() {
    super.initState();
    getExerciseIndexFromName();
  }

  void getExerciseIndexFromName() {
    exerciseIndex = global.exercises
        .indexWhere((element) => element.name == widget.exerciseName);
  }

//Launches Youtube for the video of the exercise
  void launchVideo() async {
    Uri url = Uri.parse(global.exerciseVideoUrls[exerciseIndex]);
    if (!await launchUrl(url)) log('Could not launch $url');
  }

  void completeExercise() {
    global.exercises[exerciseIndex].userValue = repCountValue;
    Navigator.pop(context, "Completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'exerciseCard' + widget.exerciseName,
            child: SingleChildScrollView(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    global.exercises[exerciseIndex].imageURL,
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: const Alignment(-1, -1),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.all<double>(10),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Icon(Icons.chevron_left)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            global.exercises[exerciseIndex].name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: launchVideo,
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(5),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.ondemand_video_rounded,
                                size: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                              ),
                              Text(
                                "Watch Video",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          global.exercises[exerciseIndex].description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18.0),
                          bottomRight: Radius.circular(18.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                            child: Text(
                              global.exercises[exerciseIndex].exerciseType ==
                                      ExerciseType.strength
                                  ? "How many times could you do?"
                                  : "How many seconds could you do?",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          NumberPicker(
                            value: repCountValue,
                            minValue: 0,
                            maxValue: 300,
                            itemHeight: 100,
                            textStyle: const TextStyle(fontSize: 20),
                            selectedTextStyle: const TextStyle(fontSize: 50),
                            axis: Axis.horizontal,
                            haptics: true,
                            onChanged: (int value) {
                              setState(() {
                                repCountValue = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                completeExercise();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(18.0),
                                        bottomRight: Radius.circular(18.0)),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.done_rounded,
                                    size: 30,
                                  ),
                                  const Text(
                                    'Complete',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
