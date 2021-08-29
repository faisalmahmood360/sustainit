import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/utils/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/login.dart';
import 'package:foodapp/screens/otp.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final _formKey = GlobalKey<FormState>();

  List<String> _countries = ['Germany', 'USA', 'France', 'Turkey'];
  String _firstName, _lastName, _userName, _email, _country;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var doRegister = () {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        EasyLoading.show(status: 'Registering...');
        auth
            .register(_firstName, _lastName, _userName, _email, _country)
            .then((response) {
          var result = response['data'];
          if (response['status']) {
            EasyLoading.show(status: 'OTP sending...');
            UserPreferences().saveEmail(_email);
            auth.sendOtp(_email).then((response) {
              if (response['status']) {
                Flushbar(
                  title: "OTP Sent Successfully",
                  message: 'OTP sent to your email.',
                  duration: Duration(seconds: 2),
                ).show(context);
                Timer(Duration(seconds: 1), () {
                  Navigator.pushReplacementNamed(context, '/otp');
                });
              } else {
                Flushbar(
                  title: "Sending OTP Failed",
                  message: 'The selected email is invalid.',
                  duration: Duration(seconds: 2),
                ).show(context);
              }
            });
          } else {
            EasyLoading.dismiss();
            Flushbar(
              title: "Registration Failed",
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
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 100),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 30),
                          )),
                      Container(
                          alignment: Alignment.center,
                          child: Text('Create an account to get started')),
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Flexible(
                              child: TextFormField(
                                onSaved: (value) => _firstName = value,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffFAFAFA),
                                  contentPadding: EdgeInsets.only(left: 10),
                                  labelText: 'First Name',
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
                            SizedBox(
                              width: 10.0,
                            ),
                            new Flexible(
                              child: TextFormField(
                                onSaved: (value) => _lastName = value,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffFAFAFA),
                                  contentPadding: EdgeInsets.only(left: 10),
                                  labelText: 'Last Name',
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
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          onSaved: (value) => _userName = value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffFAFAFA),
                            contentPadding: EdgeInsets.only(left: 10),
                            labelText: 'Username',
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
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          onSaved: (value) => _email = value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffFAFAFA),
                            contentPadding: EdgeInsets.only(left: 10),
                            labelText: 'Email Address',
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
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            validator: (value) =>
                                value == null ? 'This field is required' : null,
                            hint: Text('Country'),
                            dropdownColor: Color(0xffFAFAFA),
                            icon: Icon(Icons.arrow_drop_down_outlined),
                            isExpanded: true,
                            decoration: InputDecoration.collapsed(hintText: ''),
                            value: _country,
                            onChanged: (newValue) {
                              setState(() {
                                _country = newValue;
                              });
                            },
                            items: _countries.map((location) {
                              return DropdownMenuItem(
                                child: new SizedBox(
                                    width: 200.0, child: new Text(location)),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: FlatButton(
                              onPressed: () =>
                                  setState(() => _isChecked = !_isChecked),
                              child: Row(children: [
                                SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Checkbox(
                                        value: _isChecked,
                                        onChanged: (value) {
                                          setState(() => _isChecked = value);
                                        })),
                                SizedBox(width: 5.0),
                                Row(
                                  children: [
                                    Text("I have read the"),
                                    Text("Terms and Conditions",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ],
                                )
                              ]))),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xff50E569),
                                child: Text('Sign Up'),
                                onPressed: () {
                                  doRegister();
                                  if (_formKey.currentState.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Registering...')));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)))),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new SvgPicture.asset(
                              'assets/images/login_with_google.svg',
                            ),
                            new Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: new Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(width: 60),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 50.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new SvgPicture.asset(
                                'assets/images/login_with_apple.svg',
                              ),
                              new Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: new Text(
                                    "Login with Apple",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(width: 60),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                      child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: Text("SIGN IN",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
