enum ExerciseType { cardio, strength, rest }

class Exercise {
  Exercise(
      {required this.name,
      this.imageURL = "",
      this.videoURL = "",
      required this.description,
      required this.exerciseType,
      this.totalValueForSet = 0,
      this.currentValueInSet = 0,
      this.userValueInSet = 0});

  String name; //Name of the exercise
  String imageURL; //URL of Image
  String videoURL; //URL of YouTube Video
  String description; //Description of the exercise
  ExerciseType exerciseType; //Cardio / Strength / Rest
  int totalValueForSet; //The total reps/seconds user has to perform in the set
  int currentValueInSet; //Applicable for cardio and rest - time left to complete set
  int userValueInSet; //Reps/Seconds user performed in the set
}
