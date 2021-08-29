import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/models/ApiModels/GetCompeteUserModel.dart';
import 'package:foodapp/models/ApiModels/GetuserDetailDashboardModel.dart';
import 'package:foodapp/screens/compete.dart';
import 'package:http/http.dart';

class ProfileTwo extends StatefulWidget {
  @override
  _ProfileTwo createState() => _ProfileTwo();
}

class _ProfileTwo extends State<ProfileTwo> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  GetCompeteUserModel getCompeteUserModel;
  GetUserDetailModel getUserDetailModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompeteUserDetailSubmit();
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
      body: getCompeteUserModel == null
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Image.asset('assets/images/dummy.png',
                                    height: 50)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(getCompeteUserModel.data.name ?? '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text(getCompeteUserModel.data.userName ?? '')
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text('Type',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text(getCompeteUserModel.data.dietType ?? '')
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Meal Size',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 2),
                                  Text(getCompeteUserModel.data.dietSize ?? '')
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
                                  getCompeteUserModel.data.rank == null
                                      ? Text('No Rank')
                                      : Text(getCompeteUserModel.data.rank)
                                ],
                              ),
                            ),
                            SvgPicture.asset('assets/images/share.svg')
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
                                Text(getCompeteUserModel.data.email ?? '')
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
                                Text(getCompeteUserModel.data.country ?? '')
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
                                      '${getUserDetailModel.totalScore} ?? 0',
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
                                      '${getUserDetailModel.foodTodayScore} ?? 0',
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
                                      '${getUserDetailModel.travelTodayScore} ?? 0',
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
                            Text(getCompeteUserModel.message.description,
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
                                          Text(
                                              getCompeteUserModel.message.daily,
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
                                          Text(
                                              getCompeteUserModel
                                                  .message.monthly,
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

  getCompeteUserDetailSubmit() async {
    print('andr');
    var apis = ApiManager();
    Response response = await apis.getCompeteUserDetailApi();
    if (response.statusCode == 200) {
      getCompeteUserModel =
          GetCompeteUserModel.fromJson(jsonDecode(response.body));
      setState(() {});
    }
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
