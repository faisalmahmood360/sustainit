import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:foodapp/screens/leader_board.dart';
import 'package:foodapp/screens/profile_two.dart';
import 'package:foodapp/utils/shared_preference.dart';
import 'package:http/http.dart' as http;

var storage = FlutterSecureStorage();

class ProfileOne extends StatefulWidget {
  int userId;
  ProfileOne({this.userId});
  @override
  _ProfileOne createState() => _ProfileOne();
}

class _ProfileOne extends State<ProfileOne> {
  String habbit = '';
  int currentIndex = 0;
  String name;
  String email;
  String image;
  String dietType;
  int rank = 1;
  int foodTodayScore = 0;
  int foodLastMonthScore = 0;
  int travelTodayScore = 0;
  int travelLastMonthScore = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  @override
  void initState() {
    super.initState();

    UserPreferences().getHabbit().then((value) {
      print('habbitttttttt: ${value}');
      if (value == "2") {
        setState(() {
          habbit = "Vegetarian";
        });
      } else if (value == "1") {
        setState(() {
          habbit = "Vegan";
        });
      } else {
        setState(() {
          habbit = "Omnivore";
        });
      }
    });

    Future<List<dynamic>> getProfileDetails() async {
      final String apiUrl =
          "http://sustianitnew.planlabsolutions.org/api/user_profile/${widget.userId}";
      var result = await http.get(
        apiUrl,
        headers: {"content-type": "application/json"},
      );
      setState(() {
        name = json.decode(result.body)['data']['name'];
        email = json.decode(result.body)['data']['email'];
        dietType = json.decode(result.body)['data']['diet_type'];
      });
      return json.decode(result.body)['data'];
    }

    Future<List<dynamic>> getDashboardDetails() async {
      var id = await storage.read(key: 'loginId');
      final String apiUrl =
          "http://sustianitnew.planlabsolutions.org/api/dashboard/user_dashboard_detail";
      final Map<String, dynamic> formData = {"user_id": id};
      var result = await http.post(
        apiUrl,
        headers: {"content-type": "application/json"},
        body: json.encode(formData),
      );
      print('result ${json.decode(result.body)['data']}');
      setState(() {
        foodTodayScore = json.decode(result.body)['food_today_score'];
        foodLastMonthScore = json.decode(result.body)['food_lastMonth_score'];
        travelTodayScore = json.decode(result.body)['travel_today_score'];
        travelLastMonthScore =
            json.decode(result.body)['travel_lastMonth_score'];
      });
      return json.decode(result.body)['data'];
    }

    getProfileDetails();
    getDashboardDetails();
  }

  @override
  Widget build(BuildContext context) {
    var competeUser = () async {
      var id = await storage.read(key: 'loginId');
      EasyLoading.show(status: 'Adding compete...');

      final String addMealUrl =
          "http://sustianitnew.planlabsolutions.org/api/compete/save_compete";
      final Map<String, dynamic> formData = {
        "user_id": id,
        "competitor_id": widget.userId,
        "user_type": habbit
      };

      var result = await http.post(
        addMealUrl,
        headers: {"content-type": "application/json"},
        body: json.encode(formData),
      );
      Timer(Duration(seconds: 1), () {
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/leaderBoard');
      });
      print('result: ${result.body}');
    };

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: SvgPicture.asset('assets/images/back_icon.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeaderBoard()),
              );
            }),
        title: Text(
          'Profile',
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: name == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                    padding: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: image == null
                                  ? Image.asset('assets/images/dummy.png')
                                  : Image.network(
                                      'https://sustianitnew.planlabsolutions.org/uploads/${widget.userId}/${image}'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text(email)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Type',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 2),
                                  Text(dietType)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Rank',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 2),
                                  Text('${rank}')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 100,
                                      height: 50,
                                      child: RaisedButton(
                                          textColor: Colors.white,
                                          color: Color(0xff50E569),
                                          child: Text('Compete'),
                                          onPressed: () {
                                            competeUser();
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0)))),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text('Your Stats'),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('TOTAL',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff50E569),
                                        )),
                                    Image.asset('assets/images/diary_1.png')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Today',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(
                                          foodTodayScore + travelTodayScore),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'score',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('30 days',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(foodLastMonthScore +
                                          travelLastMonthScore),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'score',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('FOOD',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff50E569),
                                        )),
                                    Image.asset('assets/images/diary_2.png')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Today',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(foodTodayScore),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'score',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('30 days',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(foodLastMonthScore),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'score',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('TRAVEL',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff50E569),
                                        )),
                                    Image.asset('assets/images/diary_3.png')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Today',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(travelTodayScore),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'score',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('30 days',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(travelLastMonthScore),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'score',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
    ));
  }
}
