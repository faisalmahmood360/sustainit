import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTrip extends StatefulWidget {
  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  List<String> _distanceTypes = ['Meter', 'KM', 'Mile'];
  List<dynamic> _transport_types = [];
  List<String> _gasolineVehicles = [];
  List<String> _hybridVehicles = [];
  List<String> _electricVehicles = [];
  String _selectedTransportType;
  List<int> _tripDays = [3];
  final _formKey = GlobalKey<FormState>();
  List<bool> _fuel_types = [true, false, false];
  String _tripTitle,
      _tripDistance,
      _distanceType = "Meter",
      _tripType = "regular",
      _vehicleName = "",
      _fuelType = "1";
  List<dynamic> gasoline = [];

  final String apiUrl =
      "http://sustianitnew.planlabsolutions.org/api/travel/trip_detail";

  Future<List<dynamic>> fetchTripData() async {
    var result = await http.get(apiUrl);
    setState(() {
      _gasolineVehicles = json
          .decode(result.body)['data']['vehical']['gasoline']
          .cast<String>();
      _hybridVehicles =
          json.decode(result.body)['data']['vehical']['hybrid'].cast<String>();
      _electricVehicles = json
          .decode(result.body)['data']['vehical']['electric']
          .cast<String>();
      _transport_types = json
          .decode(result.body)['data']['vehical']['gasoline']
          .cast<String>();
      _vehicleName = json.decode(result.body)['data']['vehical']['gasoline'][0];
    });
    return json.decode(result.body)['data'];
  }

  void initState() {
    super.initState();
    fetchTripData();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var addTrip = () async {
      var id = await storage.read(key: 'loginId');
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        EasyLoading.show(status: 'Adding travel...');
        print('vehicle:  ${_vehicleName.toLowerCase()}');
        print('_fuelType:  ${_fuelType}');
        auth
            .addTravel(_tripTitle, _tripDistance, _distanceType, _tripDays,
                _tripType, _vehicleName.toLowerCase(), _fuelType, id)
            .then((response) {
          var result = response['data'];
          if (response['status']) {
            print(response);
            Timer(Duration(seconds: 1), () {
              EasyLoading.dismiss();
              Navigator.pushReplacementNamed(context, '/travel');
            });
          } else {
            EasyLoading.dismiss();
            Flushbar(
              title: "Adding Trip Failed",
              message: result.toString(),
              duration: Duration(seconds: 2),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 2),
        ).show(context);
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
                    Navigator.pushReplacementNamed(context, '/dashboard'),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 90),
                      child: Text(
                        'Add Travel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 30),
                      )),
                  Container(
                      child: Text(
                          'Please add your first Regular Travel e.g. Office, Work Travel',
                          textAlign: TextAlign.center)),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trip Title'),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: TextFormField(
                            onSaved: (value) => _tripTitle = value,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffFAFAFA),
                              contentPadding: EdgeInsets.only(left: 10),
                              labelText: 'Answer',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('How far do you travel?'),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) => _tripDistance = value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffFAFAFA),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    labelText: 'Answer',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Color(0xffFAFAFA),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    hint: Text('Distance type'),
                                    dropdownColor: Color(0xffFAFAFA),
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    value: _distanceType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _distanceType = newValue;
                                      });
                                    },
                                    items: _distanceTypes.map((_distanceType) {
                                      return DropdownMenuItem(
                                        child: new SizedBox(
                                            child: new Text(_distanceType)),
                                        value: _distanceType,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trip type?'),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripType == "regular"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Regular',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        _tripType = "regular";
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripType == "occasional"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Occasional',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        setState(() {
                                          _tripType = "occasional";
                                        });
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('How many days a week do you travel?'),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripDays.contains(1)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('M',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (_tripDays.contains(1)) {
                                        setState(() {
                                          _tripDays.remove(1);
                                        });
                                      } else {
                                        setState(() {
                                          _tripDays.add(1);
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripDays.contains(2)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('T',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (_tripDays.contains(2)) {
                                        setState(() {
                                          _tripDays.remove(2);
                                        });
                                      } else {
                                        setState(() {
                                          _tripDays.add(2);
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripDays.contains(3)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('W',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (_tripDays.contains(3)) {
                                        setState(() {
                                          _tripDays.remove(3);
                                        });
                                      } else {
                                        setState(() {
                                          _tripDays.add(3);
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripDays.contains(4)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('T',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (_tripDays.contains(4)) {
                                        setState(() {
                                          _tripDays.remove(4);
                                        });
                                      } else {
                                        setState(() {
                                          _tripDays.add(4);
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripDays.contains(5)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('F',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (_tripDays.contains(5)) {
                                        setState(() {
                                          _tripDays.remove(5);
                                        });
                                      } else {
                                        setState(() {
                                          _tripDays.add(5);
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripDays.contains(6)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('S',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (_tripDays.contains(6)) {
                                        setState(() {
                                          _tripDays.remove(6);
                                        });
                                      } else {
                                        setState(() {
                                          _tripDays.add(6);
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _tripDays.contains(7)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('S',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (_tripDays.contains(7)) {
                                        setState(() {
                                          _tripDays.remove(7);
                                        });
                                      } else {
                                        setState(() {
                                          _tripDays.add(7);
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What type of fuel does it use?'),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _fuelType == "1"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Gasoline',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        _fuelType = "1";
                                        _transport_types = _gasolineVehicles;
                                        _vehicleName = _gasolineVehicles[0];
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _fuelType == "2"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Hybrid',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        _fuelType = "2";
                                        _transport_types = _hybridVehicles;
                                        _vehicleName = _hybridVehicles[0];
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: ButtonTheme(
                                  minWidth: 39.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: _fuelType == "3"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Electric',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        _fuelType = "3";
                                        _transport_types = _electricVehicles;
                                        _vehicleName = _electricVehicles[0];
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What type of transport do you use?'),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Color(0xffFAFAFA),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              hint: Text('Vehicle name'),
                              dropdownColor: Color(0xffFAFAFA),
                              icon: Icon(Icons.arrow_drop_down_outlined),
                              isExpanded: true,
                              underline: SizedBox(),
                              value: _vehicleName,
                              onChanged: (newValue) {
                                setState(() {
                                  _vehicleName = newValue;
                                });
                              },
                              items: _transport_types.map((location) {
                                return DropdownMenuItem(
                                  child: new SizedBox(
                                      width: 200.0,
                                      child: new Text(
                                          toBeginningOfSentenceCase(location))),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Color(0xff50E569),
                            child: Text('+ Add Trip'),
                            onPressed: () {
                              addTrip();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
