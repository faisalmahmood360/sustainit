import 'dart:async';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/models/ApiModels/todayMealStatModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  DateTime _selectedValue = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  int selectedIndex = 0;
  TodayMealStatModel todayMealStatModel;

  // List<dynamic> list = [];
  List<List<Map<String, Object>>> list = [
    [
      {
        "id": 41,
        "name": "tomato",
        "image": "1.jpeg",
        "category_id": 1,
        "eatinghabit": "1",
        "score": 10,
        "created_at": "2021-08-01T17:51:06.000000Z",
        "updated_at": "2021-08-01T17:51:06.000000Z",
        "category": {
          "id": 1,
          "name": "Fruits",
          "created_at": "2021-06-10T03:06:20.000000Z",
          "updated_at": "2021-06-10T03:06:20.000000Z"
        }
      },
    ],
    [
      {
        "id": 41,
        "name": "tomato",
        "image": "1.jpeg",
        "category_id": 1,
        "eatinghabit": "1",
        "score": 10,
        "created_at": "2021-08-01T17:51:06.000000Z",
        "updated_at": "2021-08-01T17:51:06.000000Z",
        "category": {
          "id": 1,
          "name": "Fruits",
          "created_at": "2021-06-10T03:06:20.000000Z",
          "updated_at": "2021-06-10T03:06:20.000000Z"
        }
      },
      {
        "id": 42,
        "name": "potato",
        "image": "2.jpeg",
        "category_id": 3,
        "eatinghabit": "2",
        "score": 11,
        "created_at": "2021-08-01T17:51:06.000000Z",
        "updated_at": "2021-08-01T17:51:06.000000Z",
        "category": {
          "id": 3,
          "name": "Meat",
          "created_at": "2021-06-10T03:06:31.000000Z",
          "updated_at": "2021-06-10T03:06:31.000000Z"
        }
      },
    ],
  ];
  Map<String, double> dataMap = {
    "Meats": 5,
    "Fruits": 3,
    "Vegetables": 2,
    "Bakery": 2,
  };

  final String apiUrl =
      "http://sustianitnew.planlabsolutions.org/api/food/get_user_meal";
  final Map<String, dynamic> formData = {
    "start_date": "2021-04-26",
    "end_date": "2021-09-26",
    "user_id": 1
  };

  Future<Map<String, dynamic>> fetchMeals() async {
    var result = await http.post(
      apiUrl,
      headers: {"content-type": "application/json"},
      body: json.encode(formData),
    );
    print(
        'dataaaaaaaaaaaaaaaaa: ${json.decode(result.body)['data']['list']['7']}');
    print(json.decode(result.body)['data']['list'].runtimeType);
    // list = json.decode(result.body)['data']['list']['7'];
    // setState(() {
    //   list = json.decode(result.body)["data"]["list"];
    // });
  }

  void initState() {
    super.initState();
    fetchMeals();
    EasyLoading.show(status: 'Loading...');

    Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('listtttttt: ${list}');
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: SvgPicture.asset('assets/images/back_icon.svg'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/dashboard'),
              ),
              title: Text(
                'Food',
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
            body: Column(children: [
              Container(
                  padding: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height * 0.15,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 2,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xffFAFAFA),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 0.0),
                                child: Row(
                                  children: [
                                    Text(DateFormat('dd/MMM/yy')
                                            .format(_startDate)
                                            .toString() +
                                        ' - ' +
                                        DateFormat('dd/MMM/yy')
                                            .format(_endDate)
                                            .toString()),
                                    SizedBox(width: 10.0),
                                    GestureDetector(
                                        onTap: () async {
                                          final List<DateTime> picked =
                                              await DateRangePicker
                                                  .showDatePicker(
                                                      context: context,
                                                      initialFirstDate:
                                                          new DateTime.now(),
                                                      initialLastDate:
                                                          (new DateTime.now())
                                                              .add(new Duration(
                                                                  days: 7)),
                                                      firstDate:
                                                          new DateTime(2015),
                                                      lastDate: new DateTime(
                                                          DateTime.now().year +
                                                              2));
                                          if (picked != null &&
                                              picked.length == 2) {
                                            print(picked);
                                            setState(() {
                                              _startDate = picked[0];
                                              _endDate = picked[1];
                                            });
                                          }
                                        },
                                        child: SvgPicture.asset(
                                            'assets/images/today.svg')),
                                  ],
                                ),
                              )),
                          SizedBox(width: 5.0),
                          Flexible(
                              flex: 1,
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                      textColor: Colors.white,
                                      color: Color(0xff50E569),
                                      child: Text('+ Add Meal'),
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/addFood');
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  10.0)))))
                        ],
                      ),
                      SizedBox(height: 5.0),
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            print('length: ${list.length}');
                            print('indexxxxxxx: ${index}');
                            print('itemmmmmmmmm: ${list[index]}');
                            print('itemmmmmmmmm length: ${list[index].length}');
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('Meal ${index}'),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                          itemCount: list[index].length,
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      Image.asset(
                                                          'assets/images/food/food1.png'),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Noodles',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          Text('Junk Food')
                                                        ],
                                                      ),
                                                    ]),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('27',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        Text('score')
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.0),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                      SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text('Total Stats'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    selectedIndex = 0;
                                    setState(() {});
                                  },
                                  child: Text(
                                    'Today',
                                    style: TextStyle(
                                        color: selectedIndex == 0
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: selectedIndex == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  ),
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    selectedIndex = 1;
                                    setState(() {});
                                  },
                                  child: Text('30 Days',
                                      style: TextStyle(
                                          color: selectedIndex == 1
                                              ? Colors.black
                                              : Colors.grey,
                                          fontWeight: selectedIndex == 1
                                              ? FontWeight.bold
                                              : FontWeight.normal)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            selectedFun(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }

  todaytripStatApiSubmit() async {
    var apis = ApiManager();
    http.Response response = await apis.tripStatApi('today');
    if (response.statusCode == 200) {
      todayMealStatModel =
          TodayMealStatModel.fromJson(jsonDecode(response.body));
      setState(() {});
    }
  }

  selectedFun() {
    if (selectedIndex == 0) {
      return todayMealStatModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: PieChart(
                dataMap: <String, double>{
                  'Total Score': todayMealStatModel.data.totalScore.toDouble(),
                },
                animationDuration: Duration(
                  milliseconds: 800,
                ),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 10,
                centerText:
                    todayMealStatModel.data.totalScore.toString() + ' Score',
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ),
            );
    } else {
      return Center(
        child: PieChart(
          dataMap: <String, double>{
            'Total Score': todayMealStatModel.data.totalScore.toDouble(),
          },
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 10,
          centerText: todayMealStatModel.data.totalScore.toString() + ' Score',
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
        ),
      );
    }
  }
}
