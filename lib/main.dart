
import 'package:flutter/material.dart';
import 'package:the_exercise_project/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Exercise Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
      ),
      home: HomeScreen(),
      //home: ExerciseCatalog(),
      //home: ExerciseScreen(),
    );
  }
}
