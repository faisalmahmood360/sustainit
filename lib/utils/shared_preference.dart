import 'package:foodapp/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId);
    prefs.setString("firstName", user.firstName);
    prefs.setString("lastName", user.lastName);
    prefs.setString("userName", user.userName);
    prefs.setString("email", user.email);
    prefs.setString("country", user.country);
    prefs.setString("token", user.token);

    print("object prefere");
    print(user.token);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("id");
    String firstName = prefs.getString("firstName");
    String lastName = prefs.getString("lastName");
    String userName = prefs.getString("userName");
    String email = prefs.getString("email");
    String country = prefs.getString("country");
    String token = prefs.getString("token");

    print('In get user ${firstName}');

    return User(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        email: email,
        country: country,
        token: token);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    prefs.remove("firstName");
    prefs.remove("lastName");
    prefs.remove("userName");
    prefs.remove("email");
    prefs.remove("country");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }

  Future<bool> saveEmail(email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    print(email);
    return prefs.commit();
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    return email;
  }

  Future<bool> saveHabbit(habbit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("habbit", habbit);
    print(habbit);
    return prefs.commit();
  }

  Future<String> getHabbit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String habbit = prefs.getString("habbit");
    return habbit;
  }
}
