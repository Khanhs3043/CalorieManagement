import 'package:calopilot/models/exercise.dart';

class ExerciseLog{
  int id;
  String userId = '';
  Exercise exercise;
  int duration;
  int kcal;
  DateTime? recordAt;
  ExerciseLog({
    required this.userId,
    required this.exercise,
    this.duration =0,
    this.kcal =0,
    this.recordAt,
    this.id = 0,
}){
    duration = exercise.duration;
    kcal = exercise.kcalPerMin;
  }
}