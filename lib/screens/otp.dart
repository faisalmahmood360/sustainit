import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:foodapp/screens/first_login.dart';
import 'package:foodapp/screens/login.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:foodapp/utils/shared_preference.dart';
import 'package:provider/provider.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String email = 'Some Email';
  @override
  void initState() {
    super.initState();
    UserPreferences().getEmail().then((value) {
      email = value;
      setState(() {
        email = value;
      });
    });
    EasyLoading.show(status: 'Loading...');

    Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var login = () async {
      EasyLoading.show(status: 'Logging in...');

      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.login(email, currentText).then((response) {
          if (response['status']) {
            Future.delayed(const Duration(seconds: 1), () {
              EasyLoading.dismiss();

            });
            Flushbar(
              title: "Logged In Successfully",
              message: 'You are successfully logged in.',
              duration: Duration(seconds: 2),
            ).show(context);
            Timer(Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(context, '/firstLogin');
            });
          } else {
            Future.delayed(const Duration(seconds: 1), () {
              EasyLoading.dismiss();
            });
            Flushbar(
              title: "Login Failed",
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
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 200),
                            child: Text(
                              'O.T.P',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 30),
                            )),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                                'Please enter the verification code sent to you')),
                        Container(
                          alignment: Alignment.center,
                          child: Text(email ?? '',
                              style: TextStyle(color: Color(0xff50E569))),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 4,
                                validator: (v) {
                                  if (v.length < 3) {
                                    return "Enter the proper OTP";
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(15),
                                  fieldHeight: 75,
                                  fieldWidth: 75,
                                  activeFillColor: hasError
                                      ? Colors.blue.shade500
                                      : Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: false,
                                controller: textEditingController,
                                keyboardType: TextInputType.number,
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    currentText = value;
                                  });
                                })),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text('Didn’t receive the code?'),
                                Text(' RESEND',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 20.0),
                          child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Color(0xff50E569),
                                  child: Text('Verify'),
                                  onPressed: () {
                                    print(currentText.length);
                                    if (currentText.length < 4) {
                                      Flushbar(
                                        title: "Sending OTP Failed",
                                        message:
                                            'The selected email is invalid.',
                                        duration: Duration(seconds: 10),
                                      ).show(context);
                                    } else {
                                      login();
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)))),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    ));
  }
}
