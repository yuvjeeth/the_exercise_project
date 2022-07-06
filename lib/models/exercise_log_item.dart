import 'package:the_exercise_project/models/exercise.dart';

class ExerciseLogItem {
  ExerciseLogItem(
      {required this.dateTime,
      required this.exercise,
      required this.performedValue});

  Exercise exercise;
  int performedValue;
  DateTime dateTime;
}
