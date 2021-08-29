// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TodayMealStatModel todayMealStatModelFromJson(String str) => TodayMealStatModel.fromJson(json.decode(str));

String todayMealStatModelToJson(TodayMealStatModel data) => json.encode(data.toJson());

class TodayMealStatModel {
  TodayMealStatModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory TodayMealStatModel.fromJson(Map<String, dynamic> json) => TodayMealStatModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.mealPercentage,
    this.totalScore,
    this.status,
  });

  List<dynamic> mealPercentage;
  int totalScore;
  bool status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mealPercentage: List<dynamic>.from(json["mealPercentage"].map((x) => x)),
    totalScore: json["totalScore"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "mealPercentage": List<dynamic>.from(mealPercentage.map((x) => x)),
    "totalScore": totalScore,
    "status": status,
  };
}
