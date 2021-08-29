// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetMealModel getMealModelFromJson(String str) => GetMealModel.fromJson(json.decode(str));

String getMealModelToJson(GetMealModel data) => json.encode(data.toJson());

class GetMealModel {
  GetMealModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory GetMealModel.fromJson(Map<String, dynamic> json) => GetMealModel(
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
    this.list,
    this.status,
  });

  Map<String, List<ListElement>> list;
  bool status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: Map.from(json["list"]).map((k, v) => MapEntry<String, List<ListElement>>(k, List<ListElement>.from(v.map((x) => ListElement.fromJson(x))))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "list": Map.from(list).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    "status": status,
  };
}

class ListElement {
  ListElement({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.eatinghabit,
    this.score,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  int id;
  String name;
  String image;
  int categoryId;
  String eatinghabit;
  int score;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    categoryId: json["category_id"],
    eatinghabit: json["eatinghabit"],
    score: json["score"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "category_id": categoryId,
    "eatinghabit": eatinghabit,
    "score": score,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category": category.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  Name name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: nameValues.map[json["name"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum Name { MEAT, FRUITS, VEGETABLE }

final nameValues = EnumValues({
  "Fruits": Name.FRUITS,
  "Meat": Name.MEAT,
  "Vegetable": Name.VEGETABLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

