import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/models/ApiModels/LeaderBoardModel.dart';
import 'package:foodapp/screens/profile_one.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int selectedIndex = 0;
  int selectedTab = 1;
  List<dynamic> leaders = [];
  Map<String, dynamic> firstLeader = {};
  Map<String, dynamic> secondLeader = {};
  Map<String, dynamic> thirdLeader = {};

  Future<Map<String, dynamic>> fetchLeaders(date, type) async {
    EasyLoading.show(status: 'Loading...');
    String apiUrl =
        'http://sustianitnew.planlabsolutions.org/api/leaderboard/get_user_leaderboard';
    final Map<String, dynamic> formData = {
      "record_of": date,
      "record_for": type
    };
    var result = await http.post(
      apiUrl,
      headers: {"content-type": "application/json"},
      body: json.encode(formData),
    );
    print('responseee: ${json.decode(result.body)["1st"]}');
    setState(() {
      leaders = json.decode(result.body)["list"];
      firstLeader = json.decode(result.body)["1st"];
      secondLeader = json.decode(result.body)["2nd"];
      thirdLeader = json.decode(result.body)["3rd"];
    });
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
    return json.decode(result.body)['list'];
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Loading...');
    fetchLeaders('lastMonth', '1');
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
  }

  LeaderBoardModel leaderBoardModel;

  @override
  Widget build(BuildContext context) {
    print('leadersssssssss: ${thirdLeader}');
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: SvgPicture.asset('assets/images/back_icon.svg'),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/dashboard'),
                ),
                title: Text(
                  'Leaderboard',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 0,
                bottom: TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedTab = index + 1;
                      });
                      fetchLeaders('lastMonth', '${index + 1}');
                    },
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff50E569),
                    ),
                    tabs: [
                      Tab(text: 'Vegetarians'),
                      Tab(text: 'Vegans'),
                      Tab(text: 'Omnivores'),
                    ]),
              ),
              body: TabBarView(children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/today.svg'),
                          GestureDetector(
                            onTap: () {
                              selectedIndex = 0;
                              fetchLeaders('today', '${selectedTab}');
                              setState(() {});
                            },
                            child: Text(
                              ' Today',
                              style: TextStyle(
                                  color: selectedIndex == 0
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: selectedIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          SvgPicture.asset('assets/images/30_days.svg'),
                          GestureDetector(
                            onTap: () {
                              selectedIndex = 1;
                              fetchLeaders('lastMonth', '${selectedTab}');
                              setState(() {});
                            },
                            child: Text(
                              ' 30 Days',
                              style: TextStyle(
                                  color: selectedIndex == 1
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: selectedIndex == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      leaders == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                secondLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '2nd',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          secondLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${secondLeader['user']['id']}/${secondLeader['user']['image']}',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  secondLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${secondLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${secondLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                                firstLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '1st',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          firstLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${firstLeader['user']['id']}/${firstLeader['user']['image']}',
                                                      height: 90,
                                                      width: 90,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  firstLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${firstLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${firstLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                                thirdLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '3rd',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          thirdLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${thirdLeader['user']['id']}/${thirdLeader['user']['image']}',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  thirdLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${thirdLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${thirdLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                              ],
                            ),
                      selectedFun(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/today.svg'),
                          GestureDetector(
                            onTap: () {
                              selectedIndex = 0;
                              fetchLeaders('today', '${selectedTab}');
                              setState(() {});
                            },
                            child: Text(
                              ' Today',
                              style: TextStyle(
                                  color: selectedIndex == 0
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: selectedIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          SvgPicture.asset('assets/images/30_days.svg'),
                          GestureDetector(
                            onTap: () {
                              selectedIndex = 1;
                              fetchLeaders('lastMonth', '${selectedTab}');
                              setState(() {});
                            },
                            child: Text(
                              ' 30 Days',
                              style: TextStyle(
                                  color: selectedIndex == 1
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: selectedIndex == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      leaders == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                secondLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '2nd',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          secondLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${secondLeader['user']['id']}/${secondLeader['user']['image']}',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  secondLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${secondLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${secondLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                                firstLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '1st',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          firstLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${firstLeader['user']['id']}/${firstLeader['user']['image']}',
                                                      height: 90,
                                                      width: 90,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  firstLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${firstLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${firstLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                                thirdLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '3rd',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          thirdLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${thirdLeader['user']['id']}/${thirdLeader['user']['image']}',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  thirdLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${thirdLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${thirdLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                              ],
                            ),
                      selectedFun(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/today.svg'),
                          GestureDetector(
                            onTap: () {
                              selectedIndex = 0;
                              fetchLeaders('today', '${selectedTab}');
                              setState(() {});
                            },
                            child: Text(
                              ' Today',
                              style: TextStyle(
                                  color: selectedIndex == 0
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: selectedIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          SvgPicture.asset('assets/images/30_days.svg'),
                          GestureDetector(
                            onTap: () {
                              selectedIndex = 1;
                              fetchLeaders('lastMonth', '${selectedTab}');
                              setState(() {});
                            },
                            child: Text(
                              ' 30 Days',
                              style: TextStyle(
                                  color: selectedIndex == 1
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: selectedIndex == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      leaders == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                secondLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '2nd',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          secondLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${secondLeader['user']['id']}/${secondLeader['user']['image']}',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  secondLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${secondLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${secondLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                                firstLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '1st',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          firstLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${firstLeader['user']['id']}/${firstLeader['user']['image']}',
                                                      height: 90,
                                                      width: 90,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  firstLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${firstLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${firstLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                                thirdLeader.isNotEmpty
                                    ? Flexible(
                                        child: Column(children: [
                                          Text(
                                            '3rd',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          thirdLeader['user']['image'] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                      'https://sustianitnew.planlabsolutions.org/uploads/${thirdLeader['user']['id']}/${thirdLeader['user']['image']}',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                      'assets/images/dummy.png',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.fill)),
                                          SizedBox(height: 5),
                                          Text(
                                              toBeginningOfSentenceCase(
                                                  thirdLeader['user']
                                                      ['first_name']),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/images/persons/flag_1.svg'),
                                              SizedBox(width: 20),
                                              Text(
                                                  '@${thirdLeader['user']['user_name']}')
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                              child: Column(
                                            children: [
                                              Text('${thirdLeader['score']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text('Score')
                                            ],
                                          ))
                                        ]),
                                      )
                                    : Flexible(
                                        child: Container(
                                        height: 198,
                                        width: 108,
                                      )),
                              ],
                            ),
                      selectedFun(),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  vegetarianCard(userId, img, name, userName, score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileOne(userId: userId)));
          },
          child: Row(children: [
            Container(
              height: 48,
              width: 48,
              child: img != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                          'https://sustianitnew.planlabsolutions.org/uploads/${userId}/${img}',
                          height: 48,
                          width: 48,
                          fit: BoxFit.fill))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset('assets/images/dummy.png',
                          height: 48, width: 48, fit: BoxFit.fill)),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(toBeginningOfSentenceCase(name) ?? '',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    // SvgPicture.asset(
                    //     'assets/images/persons/flag_2.svg'),
                    SizedBox(width: 3),
                    Text('@${userName}' ?? '')
                  ],
                ),
              ],
            ),
          ]),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(score ?? '0',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('score')
          ],
        ),
        SizedBox(height: 65.0),
      ],
    );
  }

  selectedFun() {
    if (selectedIndex == 0) {
      return Expanded(
        child: Container(
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: leaders.length,
              itemBuilder: (context, index) {
                return vegetarianCard(
                    leaders[index]['user_id'],
                    leaders[index]['image'],
                    leaders[index]['name'],
                    leaders[index]['user_name'],
                    leaders[index]['score'].toString());
              }),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: leaders.length,
              itemBuilder: (context, index) {
                return vegetarianCard(
                    leaders[index]['user_id'],
                    leaders[index]['image'],
                    leaders[index]['name'],
                    leaders[index]['user_name'],
                    leaders[index]['score'].toString());
              }),
        ),
      );
    }
  }
}
