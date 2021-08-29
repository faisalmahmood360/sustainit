import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/screens/add_trip.dart';
import 'package:foodapp/screens/trip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class EditTrip extends StatefulWidget {
  String title;
  String travel;
  String distance;
  String type;
  List days;
  var fuelType;
  String transport;
  var tripId;

  EditTrip(
      {this.title,
      this.days,
      this.distance,
      this.fuelType,
      this.transport,
      this.travel,
      this.type,
      this.tripId,
      });

  @override
  _EditTripState createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  List<String> _distanceTypes = ['Meter', 'KM', 'Mile'];
  List<String> _transport_types = [];
  List<String> _gasolineVehicles = ['Toyota'];
  List<String> _hybridVehicles = ['Honda'];
  List<String> _electricVehicles = ['Szuki'];
  String _selectedTransportType;
  // List<int> _tripDays = widget.days;
  final _formKey = GlobalKey<FormState>();
  List<bool> _fuel_types = [true, false, false];
  String _tripTitle,
      _tripDistance,
      _distanceType = "Meter",
      _tripType,
      _vehicleName = "Toyota",
      _fuelType = "1";
  int _userId = 1;

  final String apiUrl =
      "http://sustianitnew.planlabsolutions.org/api/travel/trip_detail";
  final Map<String, dynamic> formData = {'habbites': '1'};

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    setState(() {
      _gasolineVehicles = json.decode(result.body)['data'];
    });
    print(json.decode(result.body)['data']);
    return json.decode(result.body)['data'];
  }

  void initState() {
    super.initState();
    fetchUsers();
    setState(() {
      _transport_types = _gasolineVehicles;
    });
  }
 final titleController = TextEditingController();
  final distanceController = TextEditingController();
 var storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    print('gasoline list: ${_gasolineVehicles}');
    var editTrip = () async{
      final form = _formKey.currentState;
      if (form.validate()) {
        var id = await storage.read(key: 'loginId');
        form.save();
        EasyLoading.show(status: 'Editing travel...');
        print('Trip title ${widget.title}');
        print('Trip days ${widget.days}');
        print('Fuel type ${widget.fuelType}');
        print('Distance type ${widget.distance}');
        auth
            .editTravel(widget.tripId,widget.title, widget.distance, widget.travel, widget.days,
            widget.type, widget.transport, widget.fuelType,id)
            .then((response) {
          var result = response['data'];
          if (response['status']) {
            print(response);
            Timer(Duration(seconds: 1), () {
              EasyLoading.dismiss();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Trip()));
            });
          } else {
            EasyLoading.dismiss();
            Flushbar(
              title: "Editing Trip Failed",
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
                  onPressed: () => Navigator.pop(context)),
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
                        'Edit Travel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 30),
                      )),
                  Container(
                      child: Text('Please edit your Travel',
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
                            onChanged: (text) {

                              widget.title = text;
                            },
                            initialValue: widget.title,
                            // onSaved: (value) => _tripTitle = value,
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
                                  onChanged: (text) {

                                    widget.distance = text;
                                  },

                                  initialValue: widget.distance,
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
                                    value: widget.travel,
                                    onChanged: (newValue) {
                                      setState(() {
                                        widget.travel = newValue;
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
                                    color: widget.type == "regular"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Regular',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        widget.type = "regular";
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
                                    color: widget.type == "occasional"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Occasional',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        setState(() {
                                          widget.type = "occasional";
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
                                    color: widget.days.contains(1)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('M',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (widget.days.contains(1)) {
                                        setState(() {
                                          widget.days.remove(1);
                                        });
                                      } else {
                                        setState(() {
                                          widget.days.add(1);
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
                                    color: widget.days.contains(2)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('T',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (widget.days.contains(2)) {
                                        setState(() {
                                          widget.days.remove(2);
                                        });
                                      } else {
                                        setState(() {
                                          widget.days.add(2);
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
                                    color: widget.days.contains(3)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('W',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (widget.days.contains(3)) {
                                        setState(() {
                                          widget.days.remove(3);
                                        });
                                      } else {
                                        setState(() {
                                          widget.days.add(3);
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
                                    color: widget.days.contains(4)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('T',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (widget.days.contains(4)) {
                                        setState(() {
                                          widget.days.remove(4);
                                        });
                                      } else {
                                        setState(() {
                                          widget.days.add(4);
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
                                    color: widget.days.contains(5)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('F',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (widget.days.contains(5)) {
                                        setState(() {
                                          widget.days.remove(5);
                                        });
                                      } else {
                                        setState(() {
                                          widget.days.add(5);
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
                                    color: widget.days.contains(6)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('S',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (widget.days.contains(6)) {
                                        setState(() {
                                          widget.days.remove(6);
                                        });
                                      } else {
                                        setState(() {
                                          widget.days.add(6);
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
                                    color: widget.days.contains(7)
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('S',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      if (widget.days.contains(7)) {
                                        setState(() {
                                          widget.days.remove(7);
                                        });
                                      } else {
                                        setState(() {
                                          widget.days.add(7);
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
                                    color: widget.fuelType == "1"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Gasoline',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        widget.fuelType = "1";
                                        _transport_types = _gasolineVehicles;
                                        widget.transport = "Toyota";
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
                                    color: widget.fuelType == "2"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Hybrid',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        widget.fuelType = "2";
                                        _transport_types = _hybridVehicles;
                                        widget.transport = "Honda";
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
                                    color: widget.fuelType == "3"
                                        ? Color(0xff50E569)
                                        : Color(0xffFAFAFA),
                                    child: Text('Electric',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () {
                                      setState(() {
                                        widget.fuelType = "3";
                                        _transport_types = _electricVehicles;
                                        widget.transport = "Szuki";
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
                              value: widget.transport,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.transport = newValue;
                                });
                              },
                              items: _transport_types.map((location) {
                                return DropdownMenuItem(
                                  child: new SizedBox(
                                      width: 200.0, child: new Text(location)),
                                  value: widget.transport,
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
                            child: Text('Update Trip'),
                            onPressed: () {

                              print('Title: ' +
                                  widget.title +
                               'Distance: ' +   widget.distance.toString() +
                                'Travel: ' + widget.travel.toString()  +
                                'Type: ' +  widget.type.toString() +
                                 'Days: ' +  widget.days.toString() +
                                 'FuelType: ' + widget.fuelType.toString() +
                                 'Transport: ' +  widget.transport + widget.tripId);
                              editTrip();
                              // editTripSubmit(widget.tripId, widget.title, widget.distance.toString(), widget.travel.toString(),widget.days.toList(), widget.type.toString() ,   widget.fuelType.toString(),  widget.transport );
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
  editTripSubmit(tripId,title,distance,distanceType,List tripDays,tripType,fuelType,vehicleName)async{
    var apis = ApiManager();
    Response response = await apis.editTravelApi(tripId, title, distance, distanceType, tripDays, tripType, fuelType, vehicleName);
    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTrip()));
    }
    else{

    }

  }
}
