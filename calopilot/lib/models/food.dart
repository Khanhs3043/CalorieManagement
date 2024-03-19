class Food{
  int id;
  String name;
  int carbs;
  int fats;
  int protein;
  int kcal;
  String nameOfServing;
  int amountOfServing;
  String? userID;

  Food({
    this.id = 0,
    this.name = '',
    this.carbs = 0,
    this.fats = 0,
    this.protein = 0,
    this.amountOfServing = 0,
    this.kcal = 0,
    this.nameOfServing = 'serving',
    this.userID
  }){
    kcal = (kcal/100*amountOfServing).round() ;
    carbs = (carbs/100*amountOfServing).round() ;
    fats = (fats/100*amountOfServing).round() ;
    protein = (protein/100*amountOfServing).round() ;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'carbs': carbs,
      'fats': fats,
      'protein': protein,
      'kcal': kcal,
      'nameOfServing': nameOfServing,
      'amountOfServing': amountOfServing,
      'userID': userID,
    };
  }
}