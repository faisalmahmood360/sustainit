// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetUserDetailModel getUserDetailModelFromJson(String str) => GetUserDetailModel.fromJson(json.decode(str));

String getUserDetailModelToJson(GetUserDetailModel data) => json.encode(data.toJson());

class GetUserDetailModel {
  GetUserDetailModel({
    this.status,
    this.message,
    this.data,
    this.userDetail,
    this.totalScore,
    this.foodLastMonthScore,
    this.foodTodayScore,
    this.travelLastMonthScore,
    this.travelTodayScore,
  });

  bool status;
  String message;
  Data data;
  UserDetail userDetail;
  int totalScore;
  int foodLastMonthScore;
  int foodTodayScore;
  int travelLastMonthScore;
  int travelTodayScore;

  factory GetUserDetailModel.fromJson(Map<String, dynamic> json) => GetUserDetailModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    userDetail: UserDetail.fromJson(json["user_detail"]),
    totalScore: json["total_score"],
    foodLastMonthScore: json["food_lastMonth_score"],
    foodTodayScore: json["food_today_score"],
    travelLastMonthScore: json["travel_lastMonth_score"],
    travelTodayScore: json["travel_today_score"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
    "user_detail": userDetail.toJson(),
    "total_score": totalScore,
    "food_lastMonth_score": foodLastMonthScore,
    "food_today_score": foodTodayScore,
    "travel_lastMonth_score": travelLastMonthScore,
    "travel_today_score": travelTodayScore,
  };
}

class Data {
  Data({
    this.daily,
    this.monthly,
    this.description,
  });

  String daily;
  String monthly;
  String description;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    daily: json["daily"],
    monthly: json["monthly"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "daily": daily,
    "monthly": monthly,
    "description": description,
  };
}

class UserDetail {
  UserDetail({
    this.name,
    this.image,
  });

  String name;
  String image;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}
