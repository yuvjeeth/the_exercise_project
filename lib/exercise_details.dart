import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:the_exercise_project/global_data.dart' as global;

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({Key? key,  required this.index})
      : super(key: key);

  final int index;

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreen();
}

class _ExerciseDetailsScreen extends State<ExerciseDetailsScreen> {
  void test() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Hero(
                tag: 'exerciseImage' + widget.index.toString(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text(
                global.exerciseNames[widget.index],
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    global.exerciseDescriptions[widget.index],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0, 0.9),
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: test,
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(5),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Watch Video',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
