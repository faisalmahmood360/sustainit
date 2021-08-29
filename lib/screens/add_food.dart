import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:provider/provider.dart';

var storage = FlutterSecureStorage();

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  List<int> _selectedFoods = [];

  final String apiUrl =
      "http://sustianitnew.planlabsolutions.org/api/food/specific_food_list";
  final Map<String, dynamic> formData = {'habbites': '1'};

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.post(
      apiUrl,
      headers: {"content-type": "application/json"},
      body: json.encode(formData),
    );
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    var addFood = () async {
      var id = await storage.read(key: 'loginId');
      if (_selectedFoods.length <= 0) {
        Flushbar(
          title: "Invalid form",
          message: "Please selecte at lest one food item",
          duration: Duration(seconds: 2),
        ).show(context);
      } else {
        EasyLoading.show(status: 'Adding meal...');

        final String addMealUrl =
            "http://sustianitnew.planlabsolutions.org/api/food/add_user_meal";
        final Map<String, dynamic> formData = {
          "food": _selectedFoods,
          "user_id": id
        };

        var result = await http.post(
          addMealUrl,
          headers: {"content-type": "application/json"},
          body: json.encode(formData),
        );
        Timer(Duration(seconds: 1), () {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, '/food');
        });
        print('result: ${result.body}');
      }
    };

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Builder(
              builder: (context) => IconButton(
                icon: SvgPicture.asset('assets/images/back_icon.svg'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/food'),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: FutureBuilder<List<dynamic>>(
              future: fetchUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.all(20.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        print('index ${index}');
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('index ${index}');
                                if (_selectedFoods
                                    .contains(snapshot.data[index]['id'])) {
                                  setState(() {
                                    _selectedFoods
                                        .remove(snapshot.data[index]['id']);
                                  });
                                } else {
                                  setState(() {
                                    _selectedFoods
                                        .add(snapshot.data[index]['id']);
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                          'https://sustianitnew.planlabsolutions.org/food_items/${snapshot.data[index]['image']}',
                                          height: 48,
                                          width: 48),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data[index]['name'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)),
                                        Text(snapshot.data[index]['category']
                                            ['name'])
                                      ],
                                    ),
                                  ]),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${snapshot.data[index]['score']}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)),
                                          Text('score')
                                        ],
                                      ),
                                      SizedBox(width: 5.0),
                                      _selectedFoods.contains(
                                              snapshot.data[index]['id'])
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                  'assets/images/tick.png',
                                                  height: 48,
                                                  width: 48),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0),
                          ],
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Positioned(
              bottom: 40,
              left: 20,
              child: SizedBox(
                  height: 50,
                  width: 350,
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xff50E569),
                      child: Text('+ Add Meal'),
                      onPressed: () {
                        addFood();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0))))),
        ]),
      ),
    );
  }
}
