import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  int currentExerciseIndex = 1;

  int repCountValue = 0;

  void test() {}

  void changeExercise(bool next) {
    next ? carouselController.nextPage() : carouselController.previousPage();
  }

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

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentExerciseIndex = index + 1;
    });
  }

  void pauseWorkoutBottomSheet() {
    showModalBottomSheet<void>(
        isDismissible: true,
        context: context,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Workout Paused",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget bottomBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.3,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () => changeExercise(false),
              child: Icon(
                Icons.chevron_left_rounded,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 50,
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
              onPressed: test,
              child: Icon(
                Icons.pause_rounded,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.3,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () => changeExercise(true),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getExerciseCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Hero(
          tag: 'exerciseCard' + index.toString(),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage(global.currentWorkout[index].imageURL)),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        global.currentWorkout[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, 0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExerciseDetailsScreen(index: index),
                            ),
                          );
                        },
                        child: Icon(Icons.more_vert_rounded),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "30",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Times",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                Container(
                    height: 30,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18)),
                        child: LinearProgressIndicator(
                          value: null,
                        ))),

                // Align(
                //   alignment: Alignment(0, 1),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Expanded(
                //         flex: 1,
                //         child: SizedBox(
                //           height: 50,
                //           child: ElevatedButton(
                //             onPressed: () {
                //               changeExercise(true);
                //             },
                //             style: ButtonStyle(
                //               backgroundColor:
                //                   MaterialStateProperty.all<Color>(
                //                       Colors.lightGreen[400]!),
                //               shape: MaterialStateProperty.all<
                //                   RoundedRectangleBorder>(
                //                 RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.only(
                //                     bottomLeft: Radius.circular(18.0),
                //                     //bottomRight: Radius.circular(18.0)
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Icon(Icons.check_rounded),
                //                 Padding(
                //                   padding:
                //                       EdgeInsets.symmetric(horizontal: 5),
                //                 ),
                //                 const Text(
                //                   'Done',
                //                   style: TextStyle(fontSize: 22),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: SizedBox(
                //           height: 50,
                //           child: ElevatedButton(
                //             onPressed: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                   builder: (context) =>
                //                       ExerciseDetailsScreen(index: index),
                //                 ),
                //               );
                //             },
                //             style: ButtonStyle(
                //               elevation: MaterialStateProperty.all<double>(0),
                //               shape: MaterialStateProperty.all<
                //                   RoundedRectangleBorder>(
                //                 RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.only(
                //                     // bottomLeft: Radius.circular(18.0),
                //                     bottomRight: Radius.circular(18.0),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 const Text(
                //                   'More',
                //                   style: TextStyle(fontSize: 22),
                //                 ),
                //                 Padding(
                //                   padding:
                //                       EdgeInsets.symmetric(horizontal: 5),
                //                 ),
                //                 Icon(Icons.chevron_right_rounded),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
        elevation: 5,
        backgroundColor: Colors.white,
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
                  // fontWeight: FontWeight.bold,
                  // color: Theme.of(context).colorScheme.primary
                  ),
            ),
            Text(
              '3',
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  // color: Theme.of(context).colorScheme.primary
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
                scrollPhysics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) =>
                    onCarouselPageChanged(index, reason),
              ),
              itemCount: global.exerciseNames.length,
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
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => changeExercise(false),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
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
                              "Strength"
                          ? test()
                          : pauseWorkoutBottomSheet();
                    },
                    child: global.currentWorkout[currentExerciseIndex - 1]
                                .exerciseType ==
                            "Strength"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done_rounded,
                                size: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
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
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
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
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => changeExercise(true),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 30,
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
