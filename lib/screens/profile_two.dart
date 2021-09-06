import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/screens/first_login.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

var storage = FlutterSecureStorage();

class ProfileTwo extends StatefulWidget {
  @override
  _ProfileTwo createState() => _ProfileTwo();
}

class _ProfileTwo extends State<ProfileTwo> {
  int currentIndex = 0;
  String name;
  String email;
  String image;
  String daily;
  String monthly;
  String description;
  String dietType;
  String dietSize;
  String country;
  int foodTodayScore = 0;
  int foodLastMonthScore = 0;
  int travelTodayScore = 0;
  int travelLastMonthScore = 0;

  File imageFile;

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

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

  void initState() {
    super.initState();

    Future<List<dynamic>> getProfileDetails() async {
      var id = await storage.read(key: 'loginId');
      final String apiUrl =
          "http://sustianitnew.planlabsolutions.org/api/user_profile/${id}";
      var result = await http.get(
        apiUrl,
        headers: {"content-type": "application/json"},
      );
      setState(() {
        name = json.decode(result.body)['data']['name'];
        email = json.decode(result.body)['data']['email'];
        image = json.decode(result.body)['data']['image'];
        country = json.decode(result.body)['data']['country'];
        dietType = json.decode(result.body)['data']['diet_type'];
        dietSize = json.decode(result.body)['data']['diet_size'];
        daily = json.decode(result.body)['message']['daily'];
        monthly = json.decode(result.body)['message']['monthly'];
        description = json.decode(result.body)['message']['description'];
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/back_icon.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          ? Center(child: CircularProgressIndicator())
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
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          height: 125,
                          width: 125,
                          child: Stack(
                            children: <Widget>[
                              image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                          'https://sustianitnew.planlabsolutions.org/uploads/${image}',
                                          height: 125,
                                          width: 125,
                                          fit: BoxFit.fill),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                          'assets/images/dummy.png',
                                          height: 125,
                                          width: 125,
                                          fit: BoxFit.fill),
                                    ),
                              Positioned(
                                bottom: 5,
                                right:
                                    1, //give the values according to your requirement
                                child: GestureDetector(
                                  onTap: () => _getFromGallery(),
                                  child: SvgPicture.asset(
                                      'assets/images/upload.svg'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(name ?? '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text(email ?? '')
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Type',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 2),
                                  Text(dietType ?? '')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Meal Size',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 2),
                                  Text(dietSize ?? '')
                                ],
                              ),
                            ),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: RaisedButton(
                                    textColor: Colors.white,
                                    color: Color(0xff50E569),
                                    child: Text('Update'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FirstLogin()),
                                      );
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)))),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text(email ?? '')
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Country',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text(country ?? '')
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    )),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text('Overall Stats'),
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
                                      k_m_b_generator(foodTodayScore +
                                          foodLastMonthScore +
                                          travelTodayScore +
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
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Food',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(
                                          foodTodayScore + foodLastMonthScore),
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
                                    Text('Travel',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                      k_m_b_generator(travelTodayScore +
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
                        margin: EdgeInsets.only(top: 20.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Color(0xff50E569),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          children: [
                            Text(description,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white)),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Daily",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          SizedBox(height: 5),
                                          Text(daily,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3fb052),
                                        borderRadius:
                                            new BorderRadius.circular(15.0)),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Monthly",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          SizedBox(height: 5),
                                          Text(monthly,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3fb052),
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
              ],
            ),
    ));
  }
}
