import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/screens/dashboard.dart';

var storage = FlutterSecureStorage();

class FirstLogin extends StatefulWidget {
  @override
  _FirstLoginState createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  int _dietType = 1;
  int _dietSize = 2;

  @override
  Widget build(BuildContext context) {
    var updateUserDiet = () async {
      EasyLoading.show(status: 'Diet updating...');
      var id = await storage.read(key: 'loginId');

      final String addMealUrl =
          "http://sustianitnew.planlabsolutions.org/api/food/update_user_diet";
      final Map<String, dynamic> formData = {
        "diet_type": _dietType,
        "diet_size": _dietSize,
        "user_id": id
      };

      var result = await http.post(
        addMealUrl,
        headers: {"content-type": "application/json"},
        body: json.encode(formData),
      );
      Timer(Duration(seconds: 1), () {
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
      print('result: ${result.body}');
    };

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
            top: 140.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Flexible(
            //       child: Column(
            //         children: [
            //           Text('Welcome Back,'),
            //           Text('Ahmad',
            //               style: TextStyle(
            //                   fontSize: 36, fontWeight: FontWeight.w700)),
            //         ],
            //       ),
            //     ),
            //     Flexible(
            //       child: Image.asset('assets/images/profile.png'),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Please select your eating habit')],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ButtonTheme(
                    minWidth: 98.0,
                    height: 98.0,
                    child: RaisedButton(
                      color: _dietType == 1
                          ? Color(0xff50E569)
                          : Color(0xffFAFAFA),
                      child: Column(
                        children: [
                          _dietType == 1
                              ? Image.asset(
                                  'assets/images/first_login/white/white_one.png')
                              : Image.asset(
                                  'assets/images/first_login/grey/grey_one.png'),
                          SizedBox(height: 10.0),
                          Text('Vegan',
                              style: TextStyle(
                                  color: _dietType == 1
                                      ? Colors.white
                                      : Color(0xffC4C4C4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          _dietType = 1;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ButtonTheme(
                    minWidth: 98.0,
                    height: 98.0,
                    child: RaisedButton(
                      color: _dietType == 2
                          ? Color(0xff50E569)
                          : Color(0xffFAFAFA),
                      child: Column(
                        children: [
                          _dietType == 2
                              ? Image.asset(
                                  'assets/images/first_login/white/white_two.png')
                              : Image.asset(
                                  'assets/images/first_login/grey/grey_two.png'),
                          SizedBox(height: 10.0),
                          Text('Vegetarian',
                              style: TextStyle(
                                  color: _dietType == 2
                                      ? Colors.white
                                      : Color(0xffC4C4C4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          _dietType = 2;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ButtonTheme(
                    minWidth: 98.0,
                    height: 98.0,
                    child: RaisedButton(
                      color: _dietType == 3
                          ? Color(0xff50E569)
                          : Color(0xffFAFAFA),
                      child: Column(
                        children: [
                          _dietType == 3
                              ? Image.asset(
                                  'assets/images/first_login/white/white_three.png')
                              : Image.asset(
                                  'assets/images/first_login/grey/grey_three.png'),
                          SizedBox(height: 10.0),
                          Text('Omnivore',
                              style: TextStyle(
                                  color: _dietType == 3
                                      ? Colors.white
                                      : Color(0xffC4C4C4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          _dietType = 3;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Please select your diet plan')],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ButtonTheme(
                    minWidth: 98.0,
                    height: 98.0,
                    child: RaisedButton(
                      color: _dietSize == 1
                          ? Color(0xff50E569)
                          : Color(0xffFAFAFA),
                      child: Column(
                        children: [
                          _dietSize == 1
                              ? Image.asset(
                                  'assets/images/first_login/white/white_four.png')
                              : Image.asset(
                                  'assets/images/first_login/grey/grey_four.png'),
                          SizedBox(height: 10.0),
                          Text('Half Plate',
                              style: TextStyle(
                                  color: _dietSize == 1
                                      ? Colors.white
                                      : Color(0xffC4C4C4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          _dietSize = 1;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ButtonTheme(
                    minWidth: 98.0,
                    height: 98.0,
                    child: RaisedButton(
                      color: _dietSize == 2
                          ? Color(0xff50E569)
                          : Color(0xffFAFAFA),
                      child: Column(
                        children: [
                          _dietSize == 2
                              ? Image.asset(
                                  'assets/images/first_login/white/white_five.png')
                              : Image.asset(
                                  'assets/images/first_login/grey/grey_five.png'),
                          SizedBox(height: 10.0),
                          Text('Full Plate',
                              style: TextStyle(
                                  color: _dietSize == 2
                                      ? Colors.white
                                      : Color(0xffC4C4C4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          _dietSize = 2;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ButtonTheme(
                    minWidth: 98.0,
                    height: 98.0,
                    child: RaisedButton(
                      color: _dietSize == 3
                          ? Color(0xff50E569)
                          : Color(0xffFAFAFA),
                      child: Column(
                        children: [
                          _dietSize == 3
                              ? Image.asset(
                                  'assets/images/first_login/white/white_six.png')
                              : Image.asset(
                                  'assets/images/first_login/grey/grey_six.png'),
                          SizedBox(height: 10.0),
                          Text('2 Plates',
                              style: TextStyle(
                                  color: _dietSize == 3
                                      ? Colors.white
                                      : Color(0xffC4C4C4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          _dietSize = 3;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xff50E569),
                      child: Text('Get Started!'),
                      onPressed: () {
                        updateUserDiet();
                        print('selected type is: ${_dietType}');
                        print('selected size is: ${_dietSize}');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)))),
            ),
          ],
        ),
      ),
    ));
  }
}
