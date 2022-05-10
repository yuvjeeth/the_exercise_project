import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:the_exercise_project/global_data.dart' as global;
import 'package:url_launcher/url_launcher.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreen();
}

class _ExerciseDetailsScreen extends State<ExerciseDetailsScreen> {
  int repCountValue = 0;

  void test() {}

  void launchVideo() async {
    Uri url = Uri.parse(global.exerciseVideoUrls[widget.index]);
    if (!await launchUrl(url)) log('Could not launch $url');
  }

  void completeWorkout(bool positive) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        context: context,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Image(
                            image: positive
                                ? AssetImage(
                                    'assets/images/UI Elements/Achievement.png')
                                : AssetImage(
                                    'assets/images/UI Elements/GetBackStronger.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          positive ? "That was Awesome 😁" : "No problem 😁",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          positive
                              ? "Keep getting stronger!"
                              : "Get back stronger and try again!",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(5),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Yep, let\'s go!',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: 'exerciseImage' + widget.index.toString(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                global.exercisesImages[widget.index],
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: const Alignment(-1, -1),
                          child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Icon(Icons.chevron_left)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          global.exerciseNames[widget.index],
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 60,
                          child: ElevatedButton(
                            onPressed: launchVideo,
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(5),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.ondemand_video_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "How many repetitions could you do?",
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
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ElevatedButton(
                              onPressed: () {
                                repCountValue == 0
                                    ? completeWorkout(false)
                                    : completeWorkout(true);
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(5),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Complete',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        global.exerciseDescriptions[widget.index],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
