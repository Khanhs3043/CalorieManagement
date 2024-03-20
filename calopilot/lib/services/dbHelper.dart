import 'dart:async';
import 'dart:io';

import 'package:calopilot/models/exLog.dart';
import 'package:calopilot/models/exercise.dart';
import "package:flutter/foundation.dart";
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/food.dart';
import '../models/foodLog.dart';
import '../models/goal.dart';
import '../models/user.dart';

class DbHelper{

  static Future<Database> mDatabase() async {
    return await openDatabase(
        'calopilot.db',
        version: 1,
        onCreate: (Database database, int version) async {
          await createTable(database);
        }
    );
  }

  static Future<void> createTable(Database database) async {
    await database.execute('''
          CREATE TABLE IF NOT EXISTS "users" (
            "id" TEXT NOT NULL PRIMARY KEY,
            "email" TEXT,
            "password" TEXT,
            "name" TEXT,
            "gender" TEXT,
            "age" INTEGER,
            "height" REAL,
            "weight" REAL
          )
        ''');
    await database.execute('''
          CREATE TABLE IF NOT EXISTS "Foods" (
            "id"	INTEGER NOT NULL,
            "name"	TEXT,
            "carbs"	INTEGER,
            "fats"	INTEGER,
            "protein"	INTEGER,
            "kcal"	INTEGER,
            "userID"	TEXT,
            "nameOfServing"	TEXT,
            "amountOfServing"	INTEGER,
            PRIMARY KEY("id" AUTOINCREMENT),
            FOREIGN KEY("userID") REFERENCES "users"("id")
          )
          ''');
        await database.execute('''CREATE TABLE IF NOT EXISTS "meals" (
      "id"	INTEGER NOT NULL,
      "userID"	TEXT,
      "name"	TEXT,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("userID") REFERENCES "users"("id")
    ) ''');
        await database.execute('''CREATE TABLE IF NOT EXISTS "exercises" (
      "id"	INTEGER NOT NULL,
      "name"	TEXT,
      "duration"	INTEGER,
      "userID"	TEXT,
      "kcalPerMin"	INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("userID") REFERENCES "users"("id")
    ) ''');
        await database.execute(''' CREATE TABLE IF NOT EXISTS "mealFoods" (
      "id"	INTEGER NOT NULL,
      "foodId"	INTEGER,
      "mealId"	INTEGER,
      "kcal"	INTEGER,
      "carbs"	INTEGER,
      "fats"	INTEGER,
      "protein"	INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("foodId") REFERENCES "Foods"("id"),
      FOREIGN KEY("mealId") REFERENCES "meals"("id")
    )''');
        await database.execute(''' CREATE TABLE IF NOT EXISTS "foodLogs" (
      "id"	INTEGER NOT NULL,
      "userID"	TEXT NOT NULL,
      "quantity"	INTEGER,
      "kcal"	INTEGER,
      "foodId"	INTEGER,
      "recordAt"	DATETIME,
      FOREIGN KEY("userID") REFERENCES "users"("id"),
      FOREIGN KEY("foodId") REFERENCES "Foods"("id"),
      PRIMARY KEY("id" AUTOINCREMENT)
    )''');
        await database.execute('''CREATE TABLE IF NOT EXISTS "exerciseLogs" (
      "id"	INTEGER NOT NULL,
      "userId"	TEXT,
      "exerciseId"	INTEGER,
      "duration"	INTEGER,
      "kcal"	INTEGER,
      "recordAt"	DATETIME,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("exerciseId") REFERENCES "Exercises"("id"),
      FOREIGN KEY("userId") REFERENCES "users"("id")
    ) ''');
        await database.execute('''CREATE TABLE IF NOT EXISTS "mealFoodLogs" (
      "id"	INTEGER NOT NULL,
      "mealFoodId"	INTEGER,
      "userId"	TEXT,
      "kcal"	INTEGER,
      "quantity"	INTEGER,
      "recordAt"	DATETIME,
      FOREIGN KEY("userId") REFERENCES "users"("id"),
      FOREIGN KEY("mealFoodId") REFERENCES "mealFoods"("id"),
      PRIMARY KEY("id" AUTOINCREMENT)
    )''');
        await database.execute('''CREATE TABLE IF NOT EXISTS "targetSettings" (
      "id"	INTEGER NOT NULL,
      "userId"	TEXT,
      "kcal"	INTEGER,
      "carbs"	INTEGER,
      "fats"	INTEGER,
      "protein"	INTEGER,
      "water"	INTEGER,
      "weightGoal"	TEXT,
      FOREIGN KEY("userId") REFERENCES "users"("id"),
      PRIMARY KEY("id" AUTOINCREMENT)
    )''');
        await database.execute('''CREATE TABLE IF NOT EXISTS "waterLogs" (
      "id"	INTEGER NOT NULL,
      "userId"	TEXT,
      "amount"	INTEGER,
      "recordAt"	DATETIME,
      FOREIGN KEY("userId") REFERENCES "users"("id"),
      PRIMARY KEY("id" AUTOINCREMENT)
    ) ''');

  }
  //about user-----------------------------------------------------------------------------------------------
  static Future createUser(mUser user)async{
    final db = await DbHelper.mDatabase();
    try{
      print(user.id);
      final data = {
        'id': user.id,
        'name' : user.name,
        'gender' : user.gender,
        'height': user.height,
        'weight': user.weight,
        'age': user.age,
      };
      await db.insert('users', data,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }catch(e){
      print(e);
    }

  }

  static Future<mUser?> getUserById(String id)async{
    final db = await DbHelper.mDatabase();
    List<Map<String, dynamic>> data = await db.query('users',where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      var user = data.first;
      return mUser(
        id: user["id"] ,
        name: user["name"] ,
        gender: user["gender"] ,
        age: user["age"],
        height: user["height"],
        weight: user["weight"],
      );
    } else {// Trả về một đối tượng Food rỗng nếu không tìm thấy
      return null;
    }

  }
  static Future<void> updateUser(mUser user) async {
    final Database db = await DbHelper.mDatabase();
    // Cập nhật thông tin người dùng trong cơ sở dữ liệu
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
    print(user.gender);
    print('Updateted');
  }
  //about goal-----------------------------------------------------------
  static Future <int>createGoal(String userId, Goal goal)async{
    final db = await DbHelper.mDatabase();
      final data = {
        'userId': userId,
        'weightGoal': goal.weightGoal,
        'kcal': goal.kcal,
        'carbs': goal.carbs,
        'fats': goal.fats,
        'protein': goal.protein,
        'water': goal.waterGoal,
      };
      var id = await db.insert('targetSettings', data,
          conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<void> updateGoal(Goal goal) async {
    final Database db = await DbHelper.mDatabase();
    await db.update(
      'targetSettings',
      goal.toMap(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }
  static Future<Goal> getGoal(String userId) async {
    final Database db = await DbHelper.mDatabase();
    List<Map<String, dynamic>> data = await db.query('targetSettings',where: 'userID = ?', whereArgs: [userId]);
    var goal = data.first;
    return Goal(
      userId: userId,
      id: goal["id"],
      weightGoal: goal["weightGoal"],
      carbs: goal["carbs"],
      fats: goal["fats"],
      protein: goal["protein"],
      waterGoal: goal["water"],
      kcal: goal["kcal"],
    );
  }
// about food------------------------------------------------
  static Future<int> createFood(Food food) async {
    final db = await DbHelper.mDatabase();
    final data = {
      'name' : food.name,
      'kcal' : food.kcal,
      'protein': food.protein,
      'carbs': food.carbs,
      'fats': food.fats,
      'nameOfServing': food.nameOfServing,
      'amountOfServing': food.amountOfServing,
      'userId': food.userID
    };
    final id = await db.insert('Foods', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Food>> getAllFoods() async {

    List<Food> listFood = [];
    final db = await DbHelper.mDatabase();
    List<Map<String, dynamic>> data = await db.query('foods');
    for (var food in data) {
      listFood.add(Food(
        id: food["id"],
        name: food["name"],
        carbs: food["carbs"],
        fats: food["fats"],
        protein: food["protein"],
        kcal: food["kcal"],
        nameOfServing: food["nameOfServing"],
        amountOfServing: food["amountOfServing"],
        userID: food["userID"],
      ));
    }
    return listFood;
  }
  static Future<List<Food>> getAllUserFoods(String userId) async {
    List<Food> listFood = [];
    final db = await DbHelper.mDatabase();
    List<Map<String, dynamic>> data = await db.query('foods',where: 'userID = ?', whereArgs: [userId]);
    for (var food in data) {
      listFood.add(Food(
        id: food["id"],
        name: food["name"],
        carbs: food["carbs"],
        fats: food["fats"],
        protein: food["protein"],
        kcal: food["kcal"],
        nameOfServing: food["nameOfServing"],
        amountOfServing: food["amountOfServing"],
        userID: food["userID"],
      ));
    }
    return listFood;
  }
  static Future<Food> getFoodById(int id) async {
    final db = await DbHelper.mDatabase();
    var data = await db.query('foods', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      var food = data.first;
      return Food(
        id: food["id"] as int,
        name: food["name"] as String,
        carbs: food["carbs"] as int,
        fats: food["fats"] as int,
        protein: food["protein"] as int,
        kcal: food["kcal"] as int,
        nameOfServing: food["nameOfServing"] as String,
        amountOfServing: food["amountOfServing"] as int,
        userID: food["userID"] as String?,
      );
    } else {// Trả về một đối tượng Food rỗng nếu không tìm thấy
      return Food();
    }
  }


  static Future<int> updateFood(Food food) async {
    final db = await DbHelper.mDatabase();
    return await db.update(
      'foods',
      food.toMap(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  static Future<void> deleteFood(int id) async {
    final db = await DbHelper.mDatabase();
    try {
      await db.delete('foods', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Co loi khi xoa food: $err");
    }
  }

  //about foodLog ----------------------------------------------------------
  static Future<List<FoodLog>> getAllFoodLogs(String userId) async {
    List<FoodLog> listFoodLogs = [];
    final db = await DbHelper.mDatabase();
    List<Map<String, dynamic>> data = await db.query('foodLogs', where: "userID = ?", whereArgs: [userId]);
    for (var foodLog in data) {
      listFoodLogs.add(FoodLog(
        id: foodLog["id"],
        quantity: foodLog["quantity"],
        kcal: foodLog["kcal"],
        food: await DbHelper.getFoodById(foodLog["foodId"]),
        recordAt: foodLog["recordAt"] != null ? DateTime.fromMillisecondsSinceEpoch(foodLog["recordAt"]) : null,
        userID: foodLog["userID"],
      ));
    }
    for (var i in listFoodLogs){
      i.calc();
    }
    print(listFoodLogs.length);
    return listFoodLogs;
  }
  static Future<int> createFoodLog(FoodLog foodLog) async {
    final db = await DbHelper.mDatabase();
    final data = {
      'quantity': foodLog.quantity,
      'kcal': foodLog.kcal,
      'foodId': foodLog.food.id,
      'recordAt': foodLog.recordAt?.millisecondsSinceEpoch,
      'userID': foodLog.userID,
    };
    final id = await db.insert('foodLogs', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  static Future<FoodLog?> getFoodLogById(int id) async {
    final db = await DbHelper.mDatabase();
    var data = await db.query('foodLogs', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      var foodLog = data.first;
      return FoodLog(
        quantity: foodLog["quantity"] as int,
        kcal: foodLog["kcal"] as int,
        food: await getFoodById(foodLog["foodId"]as int),
        recordAt: foodLog["recordAt"] as DateTime,
        userID: foodLog["userID"] as String,
      );
    } else {
      return null;
    }
  }
  static Future<int> updateFoodLog(FoodLog foodLog) async {
    final db = await DbHelper.mDatabase();
    return await db.update(
      'foodLogs',
      {
        'quantity': foodLog.quantity,
        'kcal': foodLog.kcal,
        'foodId': foodLog.food.id,
        'recordAt': foodLog.recordAt?.millisecondsSinceEpoch,
        'userID': foodLog.userID,
      },
      where: 'id = ?',
      whereArgs: [foodLog.id],
    );
  }
  static Future<void> deleteFoodLog(int id) async {
    final db = await DbHelper.mDatabase();
    try {
      await db.delete('foodLogs', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Co loi khi xoa food log: $err");
    }
  }
//about exercise -----------------------------------------------------------------------------------
  static Future<int> createExercise(Exercise exercise) async {
    final db = await DbHelper.mDatabase();
    final data = {
      'name' : exercise.name,
      'kcalPerMin' : exercise.kcalPerMin,
      'duration': exercise.duration,
      'userId': exercise.userID
    };
    final id = await db.insert('Exercises', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Exercise>> getAllExercises() async {

    List<Exercise> listExercise = [];
    final db = await DbHelper.mDatabase();
    List<Map<String, dynamic>> data = await db.query('exercises');
    for (var ex in data) {
      listExercise.add(Exercise(
        id: ex["id"],
        name: ex["name"],
        kcalPerMin: ex["kcalPerMin"],
        userID: ex["userID"],
        duration: ex["duration"]
      ));
    }
    return listExercise;
  }
  static Future<List<Exercise>> getAllUserExercises(String userId) async {
    List<Exercise> listExercise = [];
    final db = await DbHelper.mDatabase();
    List<Map<String, dynamic>> data = await db.query('exercises',where: 'userID = ?', whereArgs: [userId]);
    for (var ex in data) {
      listExercise.add(Exercise(
          id: ex["id"],
          name: ex["name"],
          kcalPerMin: ex["kcalPerMin"],
          userID: ex["userID"],
          duration: ex["duration"]
      ));
    }
    return listExercise;
  }
  static Future<Exercise> getExerciseById(int id) async {
    final db = await DbHelper.mDatabase();
    var data = await db.query('exercises', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      var ex = data.first;
      return Exercise(
        id: ex["id"] as int,
        name: ex["name"] as String,
        kcalPerMin: ex["kcalPerMin"] as int,
        duration: ex["duration"] as int,
        userID: ex["userID"] as String?,
      );
    } else {// Trả về một đối tượng Food rỗng nếu không tìm thấy
      return Exercise();
    }
  }


  // static Future<int> updateExercise(Exercise exercise) async {
  //   final db = await DbHelper.mDatabase();
  //   return await db.update(
  //     'foods',
  //     food.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [food.id],
  //   );
  // }

  static Future<void> deleteExercise(int id) async {
    final db = await DbHelper.mDatabase();
    try {
      await db.delete('Exercises', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Co loi khi xoa exercise: $err");
    }
  }
}