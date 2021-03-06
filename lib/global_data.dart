library the_exercise_project.globals;

import '/models/exercise.dart';

import 'models/exercise_log_item.dart';

List<String> dailyGreeting = [
  "serene",
  "marvellous",
  "terrific",
  "wonderful",
  "thrilling",
  "fantastic",
  "satisfying"
];

List<String> dayOfWeek = [
  "sunday",
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday"
];

List<String> exerciseNames = ["Push-ups", "Pull-ups"];

List<String> exerciseImages = [
  "assets/images/ExercisePics/Pushups.png",
  "assets/images/ExercisePics/Pullups.jpg"
];
List<String> exerciseDescriptions = [
  "In daily life, you often need to push against objects, from doors to shopping carts. The functional fitness you develop with push-ups provides the strength needed to perform these movements. \n\nIn particular, push-ups help strengthen your arms, chest, back and core which constitute of almost all of your upper body muscle groups.",
  "A pull-up is an upper-body exercise that involves hanging from a pull-up bar by your hands with your palms facing away from you, and lifting your entire body up with your arm and back muscles until your chest touches the bar.\n\nThe pull-up movement uses multiple muscles at once, including your arms, shoulders, back and core, making it a compound exercise."
];
List<String> exerciseVideoUrls = [
  "https://www.youtube.com/watch?v=IODxDxX7oi4&t=1s",
  "https://www.youtube.com/watch?v=eGo4IYlbE5g"
];

List<Exercise> exercises = [
  Exercise(
      name: exerciseNames[0],
      imageURL: exerciseImages[0],
      videoURL: exerciseVideoUrls[0],
      description: exerciseDescriptions[0],
      exerciseType: ExerciseType.strength,
      totalValueForSet: 30),
  Exercise(
      name: exerciseNames[1],
      imageURL: exerciseImages[1],
      videoURL: exerciseVideoUrls[1],
      description: exerciseDescriptions[1],
      exerciseType: ExerciseType.cardio,
      totalValueForSet: 30),
];

List<Exercise> currentWorkout = [
  Exercise(
      name: exerciseNames[0],
      imageURL: exerciseImages[0],
      videoURL: exerciseVideoUrls[0],
      description: exerciseDescriptions[0],
      exerciseType: ExerciseType.strength,
      totalValueForSet: 30),
  Exercise(
      name: "Rest",
      description: "Take a breather and get ready for the next exercise",
      exerciseType: ExerciseType.rest,
      totalValueForSet: 30),
  Exercise(
      name: exerciseNames[1],
      imageURL: exerciseImages[1],
      videoURL: exerciseVideoUrls[1],
      description: exerciseDescriptions[1],
      exerciseType: ExerciseType.cardio,
      totalValueForSet: 30),
];

List<ExerciseLogItem> userExerciseLog = [];
