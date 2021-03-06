import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodapp/screens/EditTrip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:pie_chart/pie_chart.dart';

var storage = FlutterSecureStorage();

class TravelStats {
  String hybrid;
  String electric;
  String gasoline;

  TravelStats({this.hybrid, this.electric, this.gasoline});

  factory TravelStats.fromJson(Map<String, dynamic> json) => TravelStats(
      hybrid: json['Hybrid'],
      electric: json['Electric'],
      gasoline: json['Gasoline']);

  Map<String, dynamic> toJson() => {
        "hybrid": hybrid,
        "electric": electric,
        "gasoline": gasoline,
      };
}

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  DateTime _selectedValue = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  DateTime selectedDate;
  int selectedIndex = 0;
  TravelStats travelStats;

  @override
  void initState() {
    super.initState();
    fetchTravelStats("today");
  }

  @override
  Widget build(BuildContext context) {
    final String apiUrl =
        "http://sustianitnew.planlabsolutions.org/api/travel/get_user_travel";

    Future<List<dynamic>> fetchUsers() async {
      var id = await storage.read(key: 'loginId');
      final Map<String, dynamic> formData = {
        "start_date": DateFormat('yyyy-MM-dd').format(_startDate).toString(),
        "end_date": DateFormat('yyyy-MM-dd').format(_endDate).toString(),
        "user_id": id
      };

      var result = await http.post(
        apiUrl,
        headers: {"content-Type": "application/json"},
        body: json.encode(formData),
      );
      return json.decode(result.body)['data']['list'];
    }

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
            'Travel',
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
        body: Column(
          children: [
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
                                        // showPicker(context);
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
                                    child: Text('+ Add Trip'),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/addTravel');
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)))))
                      ],
                    ),
                    SizedBox(height: 5.0),
                  ],
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: 400,
                      child: FutureBuilder<List<dynamic>>(
                        future: fetchUsers(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                padding: EdgeInsets.all(8),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(toBeginningOfSentenceCase(
                                            snapshot.data[index]['trip_type'])),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditTrip(
                                                        title:
                                                            snapshot.data[index]
                                                                ['trip_title'],
                                                        distance: snapshot
                                                            .data[index][
                                                                'trip_distance']
                                                            .toString(),
                                                        travel: snapshot
                                                                .data[index]
                                                            ['distance_type'],
                                                        type:
                                                            snapshot.data[index]
                                                                ['trip_type'],
                                                        days:
                                                            snapshot.data[index]
                                                                ['trip_days'],
                                                        fuelType: snapshot
                                                            .data[index]
                                                                ['fuel_type']
                                                            .toString(),
                                                        transport: snapshot
                                                                .data[index]
                                                            ['vehicle_name'],
                                                        tripId: snapshot
                                                            .data[index]['id']
                                                            .toString(),
                                                      )));
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
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
                                                        Text(
                                                            snapshot.data[index]
                                                                ['trip_title'],
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        Text(
                                                            '${snapshot.data[index]['trip_distance']}${snapshot.data[index]['distance_type']}(${snapshot.data[index]['vehicle_name']})')
                                                      ],
                                                    ),
                                                  ]),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          '${snapshot.data[index]['score']}',
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
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
                                  fetchTravelStats("today");
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
                                  fetchTravelStats("lastMonth");
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
            ),
          ],
        ),
      ),
    );
  }

  final String statsApiUrl =
      "http://sustianitnew.planlabsolutions.org/api/travel/get_trip_stats";

  fetchTravelStats(value) async {
    var id = await storage.read(key: 'loginId');
    final Map<String, dynamic> formData = {"record_for": value, "user_id": id};

    var result = await http.post(
      statsApiUrl,
      headers: {"content-type": "application/json"},
      body: json.encode(formData),
    );
    travelStats =
        TravelStats.fromJson(jsonDecode(result.body)['data']['tripPercentage']);
    setState(() {});
  }

  selectedFun() {
    if (selectedIndex == 0) {
      return travelStats == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: PieChart(
                dataMap: <String, double>{
                  'Hybrid': double.parse(travelStats.hybrid),
                  'Electric': double.parse(travelStats.electric),
                  'Gasoline': double.parse(travelStats.gasoline),
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
            'Hybrid': double.parse(travelStats.hybrid),
            'Electric': double.parse(travelStats.electric),
            'Gasoline': double.parse(travelStats.gasoline),
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

  Future<Null> showPicker(
    BuildContext context,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    } else {}
  }
}
