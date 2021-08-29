
class User {
  int userId;
  String firstName;
  String lastName;
  String userName;
  String email;
  String country;
  String token;

  User({this.userId, this.firstName, this.lastName, this.userName, this.email, this.country, this.token});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['user-detail']['id'],
        firstName: responseData['user-detail']['first_name'],
        lastName: responseData['user-detail']['last_name'],
        userName: responseData['user-detail']['user_ame'],
        email: responseData['user-detail']['email'],
        country: responseData['user-detail']['country'],
        token: responseData['token']
    );
  }
}