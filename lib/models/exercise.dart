import 'package:flutter/cupertino.dart';

enum ExerciseType { cardio, strength, rest }

class Exercise {
  Exercise(
      {required this.name,
      this.imageURL = "",
      this.videoURL = "",
      required this.description,
      required this.exerciseType,
      this.totalValue = 0,
      this.currentValue = 0,
      this.userValue = 0});

  String name;
  String imageURL;
  String videoURL;
  String description;
  ExerciseType exerciseType;
  int totalValue;
  int currentValue;
  int userValue;
}
