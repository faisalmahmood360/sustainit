import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/models/ApiModels/todayMealStatModel.dart';
import 'package:foodapp/screens/edit_food.dart';
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

var storage = FlutterSecureStorage();

class FoodStats {
  String fruits;
  String vegetable;
  String meat;
  String nuts;
  String bakkery;

  FoodStats({this.fruits, this.vegetable, this.meat, this.nuts, this.bakkery});

  factory FoodStats.fromJson(Map<String, dynamic> json) => FoodStats(
      fruits: json['Fruits'],
      vegetable: json['Vegetable'],
      meat: json['Meat'],
      nuts: json['nuts'],
      bakkery: json['Bakkery']);

  Map<String, dynamic> toJson() => {
        "fruits": fruits,
        "vegetable": vegetable,
        "meat": meat,
        "nuts": nuts,
        "bakkery": bakkery
      };
}

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
  FoodStats foodStats;

  List<dynamic> list = [];
  List<int> selectedItems = [];
  Map<String, dynamic> stats = {"Fruits": 30, "Vegetable": 20};

  final String apiUrl =
      "http://sustianitnew.planlabsolutions.org/api/food/get_user_meal";

  Future<Map<String, dynamic>> fetchMeals() async {
    var id = await storage.read(key: 'loginId');
    final Map<String, dynamic> formData = {
      "start_date": DateFormat('yyyy-MM-dd').format(_startDate).toString(),
      "end_date": DateFormat('yyyy-MM-dd').format(_endDate).toString(),
      "user_id": id
    };

    var result = await http.post(
      apiUrl,
      headers: {"content-type": "application/json"},
      body: json.encode(formData),
    );
    setState(() {
      list = json.decode(result.body)['data']['data'];
    });
    return json.decode(result.body)['data']['data'];
  }

  void initState() {
    super.initState();
    fetchMeals();
    fetchMealsStats("today");
    EasyLoading.show(status: 'Loading...');

    Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                          fetchMeals();
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
                      list != null
                          ? Container(
                              height: 400,
                              child: ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text('Meal ${index + 1}'),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              var items = [];
                                              for (int i = 0;
                                                  i < list[index].length;
                                                  i++) {
                                                items.add(list[index][i]['id']);
                                              }
                                              // if (DateTime.now()
                                              //     .isAtSameMomentAs(
                                              //         new DateTime(list[index]
                                              //             [0]['created_at']))) {
                                              // } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditFood(
                                                              items: items,
                                                              mealId: list[
                                                                      index][0][
                                                                  'meal_id'])));
                                              // }
                                            },
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                    itemCount:
                                                        list[index].length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int ind) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  child: Image.network(
                                                                      'https://sustianitnew.planlabsolutions.org/food_items/${list[index][ind]['image']}',
                                                                      height:
                                                                          48,
                                                                      width:
                                                                          48),
                                                                ),
                                                                SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '${list[index][ind]['name']}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w700)),
                                                                    Text(
                                                                        '${list[index][ind]['category']['name']}')
                                                                  ],
                                                                ),
                                                              ]),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      '${list[index][ind]['score']}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w700)),
                                                                  Text('score')
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                        ],
                                                      );
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            )
                          : Container(
                              height: 200,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'No Data Availabel For Selected Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))),
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
                                    fetchMealsStats("today");
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
                                    fetchMealsStats("lastMonth");
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

  final String statsApiUrl =
      "http://sustianitnew.planlabsolutions.org/api/food/get_meal_stats";

  fetchMealsStats(value) async {
    var id = await storage.read(key: 'loginId');
    final Map<String, dynamic> formData = {"record_for": value, "user_id": id};

    var result = await http.post(
      statsApiUrl,
      headers: {"content-type": "application/json"},
      body: json.encode(formData),
    );

    foodStats =
        FoodStats.fromJson(jsonDecode(result.body)['data']['mealPercentage']);
    setState(() {});
  }

  selectedFun() {
    if (selectedIndex == 0) {
      return foodStats == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: PieChart(
                dataMap: <String, double>{
                  'Fruits': double.parse(foodStats.fruits),
                  'Vegetable': double.parse(foodStats.vegetable),
                  'Meat': double.parse(foodStats.meat),
                  'Nuts': double.parse(foodStats.nuts),
                  'Bakkery': double.parse(foodStats.bakkery)
                },
                animationDuration: Duration(
                  milliseconds: 800,
                ),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 10,
                // centerText:
                //     todayMealStatModel.data.totalScore.toString() + ' Score',
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
            'Fruits': double.parse(foodStats.fruits),
            'Vegetable': double.parse(foodStats.vegetable),
            'Meat': double.parse(foodStats.meat),
            'Nuts': double.parse(foodStats.nuts),
            'Bakkery': double.parse(foodStats.bakkery)
          },
          animationDuration: Duration(
            milliseconds: 800,
          ),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 10,
          // centerText:
          //     todayMealStatModel.data.totalScore.toString() + ' Score',
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
