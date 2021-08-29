// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetCompeteUserModel getCompeteUserModelFromJson(String str) => GetCompeteUserModel.fromJson(json.decode(str));

String getCompeteUserModelToJson(GetCompeteUserModel data) => json.encode(data.toJson());

class GetCompeteUserModel {
  GetCompeteUserModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  Message message;

  factory GetCompeteUserModel.fromJson(Map<String, dynamic> json) => GetCompeteUserModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message.toJson(),
  };
}

class Data {
  Data({
    this.name,
    this.userName,
    this.country,
    this.dietType,
    this.dietSize,
    this.image,
    this.rank,
    this.email,
  });

  String name;
  String userName;
  String country;
  dynamic dietType;
  dynamic dietSize;
  String image;
  dynamic rank;
  String email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    userName: json["user_name"],
    country: json["country"],
    dietType: json["diet_type"],
    dietSize: json["diet_size"],
    image: json["image"],
    rank: json["rank"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "user_name": userName,
    "country": country,
    "diet_type": dietType,
    "diet_size": dietSize,
    "image": image,
    "rank": rank,
    "email": email,
  };
}

class Message {
  Message({
    this.daily,
    this.monthly,
    this.description,
  });

  String daily;
  String monthly;
  String description;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
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
