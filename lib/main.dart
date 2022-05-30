import 'package:flutter/material.dart';
import 'package:the_exercise_project/exercise_screen.dart';
import 'package:the_exercise_project/exercise_screen.dart';
import 'package:the_exercise_project/exercise_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_exercise_project/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Exercise Project',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Lato',
      ),
      home: ExerciseScreen(),
    );
  }
}
