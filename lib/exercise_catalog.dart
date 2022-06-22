import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:the_exercise_project/exercise_details.dart';
import 'package:the_exercise_project/models/exercise.dart';
import 'package:the_exercise_project/global_data.dart' as global;

class ExerciseCatalog extends StatefulWidget {
  const ExerciseCatalog({Key? key}) : super(key: key);

  @override
  State<ExerciseCatalog> createState() => _ExerciseCatalog();
}

class _ExerciseCatalog extends State<ExerciseCatalog> {
  List<Exercise> exercisesSearchList = [];
  TextEditingController searchText = TextEditingController();
  FocusNode searchTextFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    exercisesSearchList = global.exercises;
  }

  void test() {}

  void clearSearchQuery() {
    setState(() {
      searchText.clear();
    });
  }

  void searchExercises(String query) {
    setState(() {});
    if (query.isEmpty) {
      exercisesSearchList = global.exercises;
    } else {
      exercisesSearchList = global.exercises
          .where((element) => element.name.toLowerCase().contains(query))
          .toList();
    }
  }

//Handles routing to the ExerciseDetails route and pauses the exercise timer
  Future<void> exerciseInfo(int index) async {
    final completion = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseDetailsScreen(
          exerciseName: exercisesSearchList[index].name,
        ),
      ),
    );
  }

//Creates the card widget for each exercise in the global exercises list
  Widget getExerciseCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          exerciseInfo(index);
        },
        child: Hero(
          tag: 'exerciseCard' + exercisesSearchList[index].name,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(0, -1),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage(exercisesSearchList[index].imageURL)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.9),
                  child: Text(
                    exercisesSearchList[index].name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
        title: Text(
          'Which exercise would you like to track?',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                //color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black87,
                      blurRadius: 5,
                      blurStyle: BlurStyle.inner), // darker color
                  BoxShadow(
                      color: Theme.of(context).colorScheme.primary,
                      spreadRadius: -0.5,
                      blurRadius: 5.0,
                      blurStyle: BlurStyle.inner)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.white,
                  maxLength: 25,
                  onChanged: searchExercises,
                  decoration: InputDecoration(
                    counter: Offstage(),
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 6, 6, 0),
        child: GridView.builder(
          itemCount: exercisesSearchList.length,
          itemBuilder: (BuildContext context, index) {
            return getExerciseCard(index);
          },
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 240),
        ),
      ),
    );
  }
}
