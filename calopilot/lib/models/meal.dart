import 'food.dart';

class Meal{
  String name;
  List<Food> foodList;
  int kcal;
  int carbs;
  int fats;
  int protein;
  String? userId;

  Meal({
    this.name = "meal",
    this.kcal = 0,
    this.protein = 0,
    this.fats = 0,
    this.carbs = 0,
    required this.foodList ,
    this.userId
  });
}