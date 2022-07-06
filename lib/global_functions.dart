import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_exercise_project/models/exercise_log_item.dart';

import 'global_data.dart' as global;

Directory appDataDir = Directory("");

String getExerciseLogInString() {
  String exerciseLogString = "";
  global.userExerciseLog.forEach((element) {
    exerciseLogString +=
        DateFormat('yyyy-MM-dd/kk:mm').format(element.dateTime) +
            "," +
            element.exercise.name +
            "," +
            element.performedValue.toString() +
            "\n";
  });
  return exerciseLogString;
}

void saveExerciseLog() async {
  appDataDir = await getApplicationDocumentsDirectory();
  File exerciseLogFile = File("$appDataDir/exerciseLog");
  exerciseLogFile.writeAsString(getExerciseLogInString());
}

void readExerciseLog() async {
  File exerciseLogFile = File("$appDataDir/exerciseLog");
  List<String> exerciseLog = await exerciseLogFile.readAsLines();
  exerciseLog.forEach((element) {
    DateTime exerciseDateTime = DateTime.parse(
        element.split(",")[0].split("/")[0] +
            " - " +
            element.split(",")[0].split("/")[1]);

    ExerciseLogItem logItem = ExerciseLogItem(
        dateTime: exerciseDateTime,
        exercise: element.split(",")[1],
        performedValue: int.parse(element.split(",")[2]));
  });
}
