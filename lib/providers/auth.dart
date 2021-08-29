import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodapp/models/ApiModels/LoginModel.dart';
import 'package:http/http.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/utils/app_url.dart';
import 'package:foodapp/utils/shared_preference.dart';

var storage = FlutterSecureStorage();
enum Status {
  NotRegistered,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _registeredInStatus = Status.NotRegistered;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> register(String firstName, String lastName,
      String userName, String email, String country) async {
    final Map<String, dynamic> registrationData = {
      'first_name': firstName,
      'last_name': lastName,
      'user_name': userName,
      'email': email,
      'country': country
    };
    return await post(
      AppUrl.register,
      headers: {"content-type": "application/json"},
      body: json.encode(registrationData),
    ).then(onRegister).catchError(onError);
  }

  Future<Map<String, dynamic>> sendOtp(String email) async {
    final Map<String, dynamic> data = {
      'email': email,
    };
    return await post(
      AppUrl.otp,
      headers: {"content-type": "application/json"},
      body: json.encode(data),
    ).then(onSendOTP).catchError(onError);
  }

  Future<Map<String, dynamic>> login(String email, String otp) async {
    print(email);
    print(otp);

    final Map<String, dynamic> data = {'email': email, 'otp': otp};
    return await post(
      AppUrl.login,
      headers: {"content-type": "application/json"},
      body: json.encode(data),
    ).then(onValue).catchError(onError);
  }

  Future<Map<String, dynamic>> addTravel(
      String tripTitle,
      String tripDistance,
      String distanceType,
      List tripDays,
      String tripType,
      String vehicleName,
      String fuleType,
      String userId) async {
    var id = await storage.read(key: 'loginId');
    final Map<String, dynamic> travelData = {
      "trip_title": tripTitle,
      "trip_distance": tripDistance,
      "distance_type": distanceType,
      "trip_days": tripDays,
      "trip_type": tripType,
      "vehicle_name": vehicleName,
      "fuel_type": fuleType,
      "user_id": id
    };
    return await post(
      AppUrl.addTravel,
      headers: {"content-type": "application/json"},
      body: json.encode(travelData),
    ).then(onRegister).catchError(onError);
  }

  Future<Map<String, dynamic>> editTravel(
      String tripId,
      String tripTitle,
      String tripDistance,
      String distanceType,
      List tripDays,
      String tripType,
      String vehicleName,
      String fuleType,
      String userId) async {
    final Map<String, dynamic> travelData = {
      'trip_id': tripId,
      "trip_title": tripTitle,
      "trip_distance": tripDistance,
      "distance_type": distanceType,
      "trip_days": tripDays,
      "trip_type": tripType,
      "vehicle_name": vehicleName,
      "fuel_type": fuleType,
      "user_id": userId
    };
    return await post(
      AppUrl.editTravel,
      headers: {"content-type": "application/json"},
      body: json.encode(travelData),
    ).then(onRegister).catchError(onError);
  }

  Future<Map<String, dynamic>> updateUserDiet(
      int dietType, int dietSize, int userId) async {
    final Map<String, dynamic> dietData = {
      "diet_type": dietType,
      "diet_size": dietSize,
      "user_id": userId
    };
    return await post(
      AppUrl.addTravel,
      headers: {"content-type": "application/json"},
      body: json.encode(dietData),
    ).then(onRegister).catchError(onError);
  }

  Future<Map<String, dynamic>> getUserDashboardDetails(int userId) async {
    final Map<String, dynamic> userData = {"user_id": userId};
    return await post(
      AppUrl.getUserDashboardDetil,
      headers: {"content-type": "application/json"},
      body: json.encode(userData),
    ).then(onRegister).catchError(onError);
  }

  static Future<FutureOr> onValue(Response response) async {
    LoginModel loginModel;
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    print('status code ${response.statusCode}');
    if (response.statusCode == 200) {
      var userData = responseData['data'];
      loginModel = LoginModel.fromJson(jsonDecode(response.body));
      await storage.write(
          key: 'loginId', value: loginModel.data.userDetail.id.toString());

//       final id = jsonDecode(userData.toString());
// ;      var id1 = id['id'];
//       print('user id: ${id1}');
      print('user data: ${userData}');

      User authUser = User.fromJson(userData);
      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static Future<FutureOr> onRegister(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    print('status code ${response.statusCode}');
    print('respnose ${response}');
    if (response.statusCode == 200) {
      var userData = responseData;
      print(userData);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': userData
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static Future<FutureOr> onSendOTP(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': 'OTP sent to your email.',
      };
    } else {
      result = {
        'status': false,
        'message': 'OTP sending failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
