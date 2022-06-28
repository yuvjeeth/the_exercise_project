import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:the_exercise_project/exercise_details.dart';
import 'package:the_exercise_project/models/exercise.dart';
import 'package:the_exercise_project/global_data.dart' as global;

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreen();
}

class _ExerciseScreen extends State<ExerciseScreen> {
  bool isInForeground = true;
  CarouselController carouselController = CarouselController();
  Timer exerciseTimer = Timer(Duration(seconds: 1), () => null);
  bool exerciseTimerEnabled = true;
  int currentExerciseIndex = 1;

  void initState() {
    super.initState();
    setState(() {
      global.currentWorkout[currentExerciseIndex - 1].currentValue =
          global.currentWorkout[currentExerciseIndex - 1].totalValue;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void dispose() {
    super.dispose();
  }

  void test() {}

//Pauses workout session
  void pauseWorkout() {
    exerciseTimerEnabled = false;
    pauseWorkoutBottomSheet();
  }

//Changes the current exercise, if next is true goes next, else goes previous
  void changeExercise(bool next) {
    next
        ? carouselController.nextPage(
            duration: Duration(milliseconds: 700), curve: Curves.ease)
        : carouselController.previousPage(
            duration: Duration(milliseconds: 700), curve: Curves.ease);
  }

//Called after each exercise is successfully completed
  void exerciseFinished(bool customExerciseValue) {
    if (customExerciseValue == false) {
      global.currentWorkout[currentExerciseIndex - 1].userValue =
          global.currentWorkout[currentExerciseIndex - 1].totalValue;
    }
    carouselController.nextPage(
        duration: Duration(milliseconds: 700), curve: Curves.ease);
  }

//Handles routing to the ExerciseDetails route and pauses the exercise timer
  Future<void> exerciseInfo(int index) async {
    exerciseTimerEnabled = false;
    final completion = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseDetailsScreen(
          exerciseName: global.currentWorkout[index].name,
        ),
      ),
    );

    exerciseTimerEnabled = true;
    if (completion != null) {
      exerciseFinished(true);
      log(completion);
    }
  }

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    //Dispose the timer if it's already running
    if (exerciseTimer != null) {
      exerciseTimer.cancel();
    }

    //Update the currentExerciseIndex variable to reflect in the appBar and other sections
    setState(() {
      currentExerciseIndex = index + 1;
      global.currentWorkout[currentExerciseIndex - 1].currentValue =
          global.currentWorkout[currentExerciseIndex - 1].totalValue;
    });

    //Start the timer if the current exercise is cardio or rest. If it's strength don't start the timer
    if (global.currentWorkout[currentExerciseIndex - 1].exerciseType !=
        ExerciseType.strength) {
      exerciseTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (exerciseTimerEnabled) {
          if (global.currentWorkout[currentExerciseIndex - 1].currentValue >
              0) {
            setState(() {
              global.currentWorkout[currentExerciseIndex - 1]
                  .currentValue--; //Downtimer from exercise time to zero
            });
          } else {
            exerciseFinished(
                false); //If timer reaches zero, consider exercise is finished
            exerciseTimer.cancel();
          }
        }
      });
    }
  }

//Bring up a Bottom Sheet that shows that the workout session is paused
  void pauseWorkoutBottomSheet() {
    showModalBottomSheet<void>(
        isDismissible: false,
        context: context,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Icon(
                          Icons.pause_circle_rounded,
                          size: 150,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "Workout Paused",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              exerciseTimerEnabled = true;
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(5),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Return to Workout',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(5),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            child: const Text(
                              'End Workout',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

//Creates the card widget for each exercise in the global currentWorkout list
  Widget getExerciseCard(int index) {
    global.exercises.indexWhere(
        (element) => element.name == global.currentWorkout[index].name);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Hero(
          tag: 'exerciseCard' + global.currentWorkout[index].name,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                global.currentWorkout[index].exerciseType != ExerciseType.rest
                    ? Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  global.currentWorkout[index].imageURL)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                      )
                    : SizedBox(),
                Expanded(
                  child: Stack(
                    children: [
                      global.currentWorkout[index].exerciseType !=
                              ExerciseType.rest
                          ? Align(
                              alignment: Alignment(1, -1),
                              child: SizedBox(
                                width: 104,
                                child: TextButton(
                                  onPressed: () {
                                    exerciseInfo(index);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.more_horiz_rounded, size: 30),
                                      Text("See more"),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      Align(
                        alignment: global.currentWorkout[index].exerciseType !=
                                ExerciseType.rest
                            ? Alignment(0, 0)
                            : Alignment(0, -0.5),
                        child: Text(
                          global.currentWorkout[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      global.currentWorkout[index].exerciseType ==
                              ExerciseType.rest
                          ? Align(
                              alignment: Alignment(0, 0),
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  global.currentWorkout[index].description,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      global.currentWorkout[index].exerciseType ==
                              ExerciseType.rest
                          ? Align(
                              alignment: Alignment(0, 0.5),
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  "Next Exercise: " +
                                      global.currentWorkout[index + 1].name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        global.currentWorkout[index].currentValue.toString(),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        global.currentWorkout[index].exerciseType ==
                                ExerciseType.strength
                            ? "Times"
                            : global.currentWorkout[index].currentValue == 1
                                ? "Second"
                                : "Seconds",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: global.currentWorkout[index].exerciseType ==
                          ExerciseType.strength
                      ? 15
                      : 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18)),
                    child: LinearProgressIndicator(
                      value: 1 -
                          (global.currentWorkout[index].currentValue /
                              global.currentWorkout[index].totalValue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$currentExerciseIndex',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25),
            ),
            Text(
              ' of ',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Text(
              global.currentWorkout.length.toString(),
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: bottomBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -1),
            child: CarouselSlider.builder(
              carouselController: carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 1.5,
                scrollPhysics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) =>
                    onCarouselPageChanged(index, reason),
              ),
              itemCount: global.currentWorkout.length,
              itemBuilder: ((context, index, ind) {
                return getExerciseCard(index);
              }),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => changeExercise(false),
                    child: Column(
                      children: [
                        Icon(
                          Icons.chevron_left_rounded,
                          size: 30,
                        ),
                        Text("Previous"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(5),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      global.currentWorkout[currentExerciseIndex - 1]
                                  .exerciseType ==
                              ExerciseType.strength
                          ? exerciseFinished(
                              false) //Exercise successfully finished
                          : pauseWorkout();
                    },
                    
                    child: global.currentWorkout[currentExerciseIndex - 1]
                                .exerciseType ==
                            ExerciseType.strength
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done_rounded,
                                size: 30,
                              ),
                              Text(
                                "Done",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pause_rounded,
                                size: 30,
                              ),
                              Text(
                                "Pause",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => changeExercise(true),
                    child: Column(
                      children: [
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 30,
                        ),
                        Text("Skip"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
