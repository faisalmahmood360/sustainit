import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:foodapp/screens/first_login.dart';
import 'package:foodapp/screens/otp.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/utils/shared_preference.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Loading...');

    Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
  }

  final _formKey = GlobalKey<FormState>();
  String _email;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var sendOTP = () async {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        EasyLoading.show(status: 'Sending OTP...');
        UserPreferences().saveEmail(_email);
        auth.sendOtp(_email).then((response) {
          if (response['status']) {
            Future.delayed(const Duration(seconds: 1), () {
              EasyLoading.dismiss();
            });
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
                          margin: EdgeInsets.only(top: 200),
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 30),
                          )),
                      Container(
                          alignment: Alignment.center,
                          child: Text('Login to get started')),
                      Container(
                        padding: EdgeInsets.only(top: 30),
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
                          child: FlatButton(
                              onPressed: () =>
                                  setState(() => _isChecked = !_isChecked),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                        child: Checkbox(
                                            value: _isChecked,
                                            onChanged: (value) {
                                              setState(
                                                  () => _isChecked = value);
                                            })),
                                    SizedBox(width: 5.0),
                                    Text("Remember Me")
                                  ]))),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xff50E569),
                                child: Text('Login'),
                                onPressed: () {
                                  sendOTP();
                                  if (_formKey.currentState.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('OTP Sending...')));
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
                                'assets/images/login_with_google.svg'),
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
                                  'assets/images/login_with_apple.svg'),
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
                              Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/register');
                                },
                                child: Text("SIGN UP",
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
