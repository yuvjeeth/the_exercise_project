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

  void test() {}

  void performExercise(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseDetailsScreen(
          index: index,
        ),
      ),
    );
  }

  Widget getExerciseCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Hero(
                    tag: 'exerciseImage' + index.toString(),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(global.exercisesImages[index])),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(-0.8, 1),
                          child: Text(
                            global.exerciseNames[index],
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.8, 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "15",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Repetitions",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment(0, 1),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () => performExercise(index),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(5),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18.0),
                              bottomRight: Radius.circular(18.0)),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Perform',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Today\'s Workout',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: global.exerciseNames.length,
          itemBuilder: ((context, index) {
            return getExerciseCard(index);
          }),
        ),
      ),
    );
  }
}
