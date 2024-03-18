import 'food.dart';

class FoodLog{
  int quantity;
  Food food;
  int kcal;
  DateTime? recordAt = DateTime.now();
  String userID;
  int carbs = 0;
  int fats = 0;
  int protein = 0;

  FoodLog({
    required this.userID,
    this.kcal =  0,
    required this.food,
    this.quantity = 0,
    this.recordAt
});
  calc(){
    kcal = food.kcal * quantity~/food.amountOfServing;
    carbs = food.carbs * quantity~/food.amountOfServing;
    fats = food.fats * quantity~/food.amountOfServing;
    protein = food.protein * quantity~/food.amountOfServing;
  }
}