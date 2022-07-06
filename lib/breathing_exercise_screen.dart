import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:the_exercise_project/exercise_details.dart';
import 'package:the_exercise_project/models/exercise.dart';
import 'package:the_exercise_project/global_data.dart' as global;

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({Key? key}) : super(key: key);

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreen();
}

class _BreathingExerciseScreen extends State<BreathingExerciseScreen> {
  List<Exercise> exercisesSearchList = [];
  TextEditingController searchText = TextEditingController();
  FocusNode searchTextFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void test() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Text("Coming Soon!"),
      ),
    );
  }
}
