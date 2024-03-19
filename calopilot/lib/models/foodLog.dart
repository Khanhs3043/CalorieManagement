import 'food.dart';

class FoodLog{
  int id;
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
    this.id = 0,
    this.kcal =  0,
    required this.food,
    this.quantity = 0,
    this.recordAt
});
  calc(){
    if(food.amountOfServing>0){
    quantity = food.amountOfServing;
    kcal = (food.kcal * quantity/food.amountOfServing).round();
    carbs = (food.carbs * quantity/food.amountOfServing).round();
    fats = (food.fats * quantity/food.amountOfServing).round();
    protein = (food.protein * quantity/food.amountOfServing).round();
  }}
}