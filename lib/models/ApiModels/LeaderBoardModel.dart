// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LeaderBoardModel leaderBoardModelFromJson(String str) =>
    LeaderBoardModel.fromJson(json.decode(str));

String leaderBoardModelToJson(LeaderBoardModel data) =>
    json.encode(data.toJson());

class LeaderBoardModel {
  LeaderBoardModel({
    this.status,
    this.vegetarian,
    this.vagens,
    this.omnivores,
  });

  bool status;
  Vegetarian vegetarian;
  List<dynamic> vagens;
  List<dynamic> omnivores;

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardModel(
        status: json["status"],
        vegetarian: Vegetarian.fromJson(json["vegetarian"]),
        vagens: List<dynamic>.from(json["vagens"].map((x) => x)),
        omnivores: List<dynamic>.from(json["omnivores"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "vegetarian": vegetarian.toJson(),
        "vagens": List<dynamic>.from(vagens.map((x) => x)),
        "omnivores": List<dynamic>.from(omnivores.map((x) => x)),
      };
}

class Vegetarian {
  Vegetarian({
    this.the1,
  });

  The1 the1;

  factory Vegetarian.fromJson(Map<String, dynamic> json) => Vegetarian(
        the1: The1.fromJson(json["1"]),
      );

  Map<String, dynamic> toJson() => {
        "1": the1.toJson(),
      };
}

class The1 {
  The1({
    this.userId,
    this.rank,
    this.image,
    this.name,
    this.country,
    this.userName,
    this.score,
    this.dietType,
  });

  int userId;
  dynamic rank;
  String image;
  String name;
  String country;
  String userName;
  int score;
  String dietType;

  factory The1.fromJson(Map<String, dynamic> json) => The1(
        userId: json["user_id"],
        rank: json["rank"],
        image: json["image"],
        name: json["name"],
        country: json["country"],
        userName: json["user_name"],
        score: json["score"],
        dietType: json["dietType"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "rank": rank,
        "image": image,
        "name": name,
        "country": country,
        "user_name": userName,
        "score": score,
        "dietType": dietType,
      };
}
