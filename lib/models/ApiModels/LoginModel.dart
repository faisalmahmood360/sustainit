// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.status,
    this.userDetail,
    this.token,
  });

  bool status;
  UserDetail userDetail;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    userDetail: UserDetail.fromJson(json["user-detail"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user-detail": userDetail.toJson(),
    "token": token,
  };
}

class UserDetail {
  UserDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.otp,
    this.country,
    this.dietType,
    this.dietSize,
    this.rank,
    this.image,
    this.email,
    this.emailVerifiedAt,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deviceToken,
  });

  int id;
  String firstName;
  String lastName;
  String userName;
  String otp;
  String country;
  dynamic dietType;
  dynamic dietSize;
  dynamic rank;
  dynamic image;
  String email;
  dynamic emailVerifiedAt;
  int active;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deviceToken;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    otp: json["otp"],
    country: json["country"],
    dietType: json["diet_type"],
    dietSize: json["diet_size"],
    rank: json["rank"],
    image: json["image"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    active: json["active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "otp": otp,
    "country": country,
    "diet_type": dietType,
    "diet_size": dietSize,
    "rank": rank,
    "image": image,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "active": active,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "device_token": deviceToken,
  };
}
