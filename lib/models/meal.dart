class Meal {
  String name;
  String image;
  String category;
  int score;

  Meal({this.name, this.image, this.category, this.score});

  factory Meal.fromJson(Map<String, dynamic> responseData) {
    return Meal(
        name: responseData['user-detail']['id'],
        image: responseData['user-detail']['first_name'],
        category: responseData['user-detail']['last_name'],
        score: responseData['user-detail']['user_ame']);
  }
}
