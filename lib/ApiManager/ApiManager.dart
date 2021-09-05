import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

var dateFormate = new DateFormat('yyyy-MM-dd');
var endDate = dateFormate.format(DateTime.now());
var storage = FlutterSecureStorage();

class ApiManager {
  contactUsApi(firstName, email, description) async {
    String url = 'http://sustianitnew.planlabsolutions.org/api/contact_us';
    final response = await http.post(Uri.parse(url), body: {
      'first_name': firstName,
      'email': email,
      'description': description
    });
    print(response.body);
    return response;
  }

  getMealApi({String endingDate, String startingDate}) async {
    String url =
        'http://sustianitnew.planlabsolutions.org/api/food/get_user_meal';
    var id = await storage.read(key: 'loginId');
    final response = await http.post(Uri.parse(url), body: {
      'start_date': '2015-09-12',
      'end_date': endDate,
      'user_id': 1.toString()
    });
    print('id is ' + id.toString());
    print('res is jvgv' + response.body);
    return response;
  }

  tripStatApi(record) async {
    String url =
        'http://sustianitnew.planlabsolutions.org/api/travel/get_trip_stats';
    var id = await storage.read(key: 'loginId');
    final response = await http.post(Uri.parse(url), body: {
      'record_for': record,
      'user_id': id.toString(),
    });
    print('res is jvgv' + response.body);
    return response;
  }

  mealStatApi(record) async {
    String url =
        'http://sustianitnew.planlabsolutions.org/api/food/get_meal_stats';
    var id = await storage.read(key: 'loginId');
    final response = await http.post(Uri.parse(url), body: {
      'record_for': record,
      'user_id': id.toString(),
    });
    print('res is jvgv' + response.body);
    return response;
  }

  editTravelApi(tripId, title, distance, distanceType, List tripDays, tripType,
      fuelType, vehicleName) async {
    String url =
        'http://sustianitnew.planlabsolutions.org/api/travel/update_user_trip';
    var id = await storage.read(key: 'loginId');
    final response = await http.post(Uri.parse(url), body: {
      'trip_id': tripId,
      'trip_title': title,
      'trip_distance': distance,
      'distance_type': distanceType,
      'trip_days': tripDays.toString(),
      'trip_type': tripType,
      'fuel_type': fuelType,
      'vehicle_name': vehicleName,
      'user_id': id.toString()
    });
    print('days' + tripDays.toString());
    print('res is jvgv' + response.body);
    return response;
  }

  getUserDetailApi() async {
    String url =
        'http://sustianitnew.planlabsolutions.org/api/dashboard/user_dashboard_detail';
    var id = await storage.read(key: 'loginId');
    final response =
        await http.post(Uri.parse(url), body: {'user_id': id.toString()});

    print('res is jvgv' + response.body);
    return response;
  }

  getCompeteUserDetailApi() async {
    print('api andr');
    var id = await storage.read(key: 'loginId');
    print('id is' + id);
    String url = 'http://sustianitnew.planlabsolutions.org/api/user_profile/' +
        id.toString();
    print('url is ' + url);
    final response = await http.get(Uri.parse(url));

    print('res is jvgv' + response.body);
    return response;
  }

  getLeaderboardDetailApi() async {
    String url =
        'http://sustianitnew.planlabsolutions.org/api/leaderboard/get_user_leaderboard';
    final response = await http.post(Uri.parse(url),
        body: {'record_of': 'lastMonth', 'record_for': "1"});
    return response;
  }
}
