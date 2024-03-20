import 'dart:core';

class Goal{
  int id;
  String userId;
  String weightGoal;
  int kcal;
  int carbs;
  int fats;
  int protein;
  int waterGoal;
  Goal({
    required this.userId,
    this.weightGoal = "Maintain weight",
    this.id = 0,
    this.kcal =0,
    this.protein =0,
    this.fats = 0,
    this.carbs = 0,
    this.waterGoal = 0
});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'weightGoal': weightGoal,
      'kcal': kcal,
      'carbs': carbs,
      'fats': fats,
      'protein': protein,
      'water': waterGoal,
    };
  }
}