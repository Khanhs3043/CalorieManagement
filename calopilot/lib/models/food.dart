class Food{
  String name;
  int carbs;
  int fats;
  int protein;
  int kcal;
  String nameOfServing;
  int amountOfServing;
  String? UserID;

  Food({
  this.name = '',
  this.carbs = 0,
  this.fats = 0,
    this.protein = 0,
    this.amountOfServing = 0,
    this.kcal = 0,
    this.nameOfServing = 'serving',
    this.UserID
  });
}