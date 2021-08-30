import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/screens/about_us.dart';
import 'package:foodapp/screens/compete.dart';
import 'package:foodapp/screens/contact_us.dart';
import 'package:foodapp/screens/food.dart';
import 'package:foodapp/screens/leader_board.dart';
import 'package:foodapp/screens/privacy_policy.dart';
import 'package:foodapp/screens/profile_one.dart';
import 'package:foodapp/screens/profile_two.dart';
import 'package:foodapp/screens/terms_and_conditions.dart';
import 'package:foodapp/screens/trip.dart';
import 'package:foodapp/utils/shared_preference.dart';
import 'package:http/http.dart' as http;

var storage = FlutterSecureStorage();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int userId;
  String name;
  String email;
  String daily;
  String monthly;
  String description;
  int foodTodayScore = 0;
  int foodLastMonthScore = 0;
  int travelTodayScore = 0;
  int travelLastMonthScore = 0;

  void initState() {
    print('hello thereeeeee');
    super.initState();
    UserPreferences().getUser().then((value) {
      print('name: ${value.email}');
      setState(() {
        userId = value.userId;
        name = value.firstName;
        email = value.email;
      });
    });

    final String apiUrl =
        "http://sustianitnew.planlabsolutions.org/api/dashboard/user_dashboard_detail";

    Future<List<dynamic>> getDashboardDetails() async {
      var id = await storage.read(key: 'loginId');
      final Map<String, dynamic> formData = {"user_id": id};
      var result = await http.post(
        apiUrl,
        headers: {"content-type": "application/json"},
        body: json.encode(formData),
      );
      print('result ${result}');
      setState(() {
        daily = json.decode(result.body)['data']['daily'];
        monthly = json.decode(result.body)['data']['monthly'];
        description = json.decode(result.body)['data']['description'];
        foodTodayScore = json.decode(result.body)['food_today_score'];
        foodLastMonthScore = json.decode(result.body)['food_lastMonth_score'];
        travelTodayScore = json.decode(result.body)['travel_today_score'];
        travelLastMonthScore =
            json.decode(result.body)['travel_lastMonth_score'];
      });
      print('response: ${json.decode(result.body)['data']}');
      return json.decode(result.body)['data'];
    }

    getDashboardDetails();

    EasyLoading.show(status: 'Loading...');

    Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
  }

  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Builder(
              builder: (context) => IconButton(
                icon: SvgPicture.asset('assets/images/drawer.svg'),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: Container(
            child: Drawer(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  DrawerHeader(
                    child: Container(
                      height: 142,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset('assets/images/dummy.png'),
                          ),
                          SizedBox(height: 10.0),
                          Text(name ?? '',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(email ?? ''),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactUs()),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/contact_us.svg'),
                          SizedBox(width: 8.0),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 3;
                        });
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AboutUs()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/about_us.svg'),
                          SizedBox(width: 8.0),
                          Text(
                            'About Us',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 3;
                        });
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/privacy_policy.svg'),
                          SizedBox(width: 8.0),
                          Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 3;
                        });
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsAndConditions()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/rate_us.svg'),
                          SizedBox(width: 8.0),
                          Text(
                            'Rate Us',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70.0,
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            EasyLoading.show(status: 'Logging out...');
                            UserPreferences().removeUser();
                            Future.delayed(const Duration(seconds: 2), () {
                              EasyLoading.dismiss();
                              Navigator.pushReplacementNamed(context, '/login');
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFFF0000),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                SvgPicture.asset('assets/images/logout.svg'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              height: MediaQuery.of(context).size.height * 0.33,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileTwo(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            children: [
                              Text('Welcome Back,'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Color(0xff50E569),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [
                        Text(description ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: Color(0xFFFAFAFA),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Daily",
                                        style: TextStyle(color: Colors.white)),
                                    Text(daily ?? '',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                onPressed: null,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: RaisedButton(
                                color: Color(0xFFFAFAFA),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Monthly",
                                        style: TextStyle(color: Colors.white)),
                                    Text(monthly ?? '',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                onPressed: null,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text('Your Stats'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.all(10.0),
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
                                Text(
                                  'TOTAL',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff50E569),
                                  ),
                                ),
                                Image.asset('assets/images/diary_1.png')
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${foodTodayScore + travelTodayScore}',
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
                                Text(
                                  '30 days',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${foodLastMonthScore + travelLastMonthScore}',
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
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Food()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(10.0),
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
                                  Text(
                                    'FOOD',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff50E569),
                                    ),
                                  ),
                                  Image.asset('assets/images/diary_2.png')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${foodTodayScore}',
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
                                  Text(
                                    '30 days',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${foodLastMonthScore}',
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
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Trip()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(10.0),
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
                                  Text(
                                    'TRAVEL',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff50E569),
                                    ),
                                  ),
                                  Image.asset('assets/images/diary_3.png')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${travelTodayScore}',
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
                                  Text(
                                    '30 days',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${travelLastMonthScore}',
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 67,
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        color: Color(0xff3A3768),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/images/leaderboard.svg'),
                            Text("Leaderboard",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaderBoard()),
                          )
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 67,
                      child: RaisedButton(
                        color: Color(0xff3A3768),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/images/compete.svg'),
                            Text(
                              "Compete",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Compete()),
                          )
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
