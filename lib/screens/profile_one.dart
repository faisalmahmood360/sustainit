import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/models/ApiModels/GetuserDetailDashboardModel.dart';
import 'package:foodapp/screens/compete.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:foodapp/screens/profile_two.dart';
import 'package:http/http.dart';

class ProfileOne extends StatefulWidget {
  @override
  _ProfileOne createState() => _ProfileOne();
}

class _ProfileOne extends State<ProfileOne> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  GetUserDetailModel getUserDetailModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetailSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: SvgPicture.asset('assets/images/back_icon.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
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
      body: getUserDetailModel == null
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
                              child: getUserDetailModel.userDetail.image == null
                                  ? Image.asset('assets/images/dummy.png')
                                  : Image.asset(
                                      getUserDetailModel.userDetail.image),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(getUserDetailModel.userDetail.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text('@kevinbryne')
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
                                  Text('Omnivore')
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
                                  Text('1')
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileTwo()),
                                            );
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
                                      getUserDetailModel.totalScore.toString(),
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
                                      getUserDetailModel.totalScore.toString(),
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
                                      getUserDetailModel.foodTodayScore
                                          .toString(),
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
                                      getUserDetailModel.foodLastMonthScore
                                          .toString(),
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
                                      getUserDetailModel.travelTodayScore
                                          .toString(),
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
                                      getUserDetailModel.travelLastMonthScore
                                          .toString(),
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

  getUserDetailSubmit() async {
    var apis = ApiManager();
    Response response = await apis.getUserDetailApi();
    if (response.statusCode == 200) {
      getUserDetailModel =
          GetUserDetailModel.fromJson(jsonDecode(response.body));
      setState(() {});
    }
  }
}
