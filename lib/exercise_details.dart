import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:the_exercise_project/global_data.dart' as global;

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


//Launches Youtube for the video of the exercise
  void launchVideo() async {
    Uri url = Uri.parse(global.exerciseVideoUrls[widget.index]);
    if (!await launchUrl(url)) log('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'exerciseCard' + widget.index.toString(),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: SingleChildScrollView(
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
                                    global
                                        .currentWorkout[widget.index].imageURL,
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
                                child: TextButton(
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
                            global.currentWorkout[widget.index].name,
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
                          global.currentWorkout[widget.index].description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
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
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18.0),
                          bottomRight: Radius.circular(18.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
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
                              child: const Text(
                                'Complete',
                                style: TextStyle(fontSize: 22),
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
