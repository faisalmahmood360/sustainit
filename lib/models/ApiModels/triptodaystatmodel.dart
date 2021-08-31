// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TripTodayStatModel tripTodayStatModelFromJson(String str) =>
    TripTodayStatModel.fromJson(json.decode(str));

String tripTodayStatModelToJson(TripTodayStatModel data) =>
    json.encode(data.toJson());

class TripTodayStatModel {
  TripTodayStatModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory TripTodayStatModel.fromJson(Map<String, dynamic> json) =>
      TripTodayStatModel(
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
    this.tripPercentage,
    this.occasionalTripScore,
    this.regularTripScore,
    this.list,
    this.status,
  });

  TripPercentage tripPercentage;
  int occasionalTripScore;
  int regularTripScore;
  List<ListElement> list;
  bool status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tripPercentage: TripPercentage.fromJson(json["tripPercentage"]),
        occasionalTripScore: json["occasionalTripScore"],
        regularTripScore: json["regularTripScore"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tripPercentage": tripPercentage.toJson(),
        "occasionalTripScore": occasionalTripScore,
        "regularTripScore": regularTripScore,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "status": status,
      };
}

class ListElement {
  ListElement({
    this.id,
    this.userId,
    this.tripTitle,
    this.tripDistance,
    this.distanceType,
    this.tripDays,
    this.tripType,
    this.vehicleName,
    this.fuelType,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String tripTitle;
  int tripDistance;
  String distanceType;
  List<int> tripDays;
  String tripType;
  String vehicleName;
  String fuelType;
  int score;
  DateTime createdAt;
  DateTime updatedAt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        userId: json["user_id"],
        tripTitle: json["trip_title"],
        tripDistance: json["trip_distance"],
        distanceType: json["distance_type"],
        tripDays: List<int>.from(json["trip_days"].map((x) => x)),
        tripType: json["trip_type"],
        vehicleName: json["vehicle_name"],
        fuelType: json["fuel_type"],
        score: json["score"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "trip_title": tripTitle,
        "trip_distance": tripDistance,
        "distance_type": distanceType,
        "trip_days": List<dynamic>.from(tripDays.map((x) => x)),
        "trip_type": tripType,
        "vehicle_name": vehicleName,
        "fuel_type": fuelType,
        "score": score,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class TripPercentage {
  TripPercentage({
    this.the3,
  });

  String the3;

  factory TripPercentage.fromJson(Map<String, dynamic> json) => TripPercentage(
        the3: json["3"],
      );

  Map<String, dynamic> toJson() => {
        "3": the3,
      };
}
