class Calculator{
  static double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }
  static double calculateBMR(String gender, double weight, double height, int age) {
    if (gender == 'male') {
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }
  }
  static double calculateTDEE(double bmr, String activityLevel) {
    double activityMultiplier = 1.0;
    if (activityLevel == 'very low') {
      activityMultiplier = 1.2;
    } else if (activityLevel == 'low') {
      activityMultiplier = 1.375;
    } else if (activityLevel == 'moderate') {
      activityMultiplier = 1.55;
    } else if (activityLevel == 'high') {
      activityMultiplier = 1.725;
    } else if (activityLevel == 'very high') {
      activityMultiplier = 1.9;
    }
    return bmr * activityMultiplier;
  }
  static double calculateDailyCalories(double tdee, String weightGoal) {
    if (weightGoal =='Lose weight') {
      return tdee - 500; // Giảm 500 kcal mỗi ngày để giảm cân
    } else if (weightGoal =='Maintain weight') {
      return tdee; // Giữ nguyên calo nếu muốn duy trì cân nặng
    }else  {
      return tdee+ 500;
    }
  }
}