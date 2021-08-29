import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/providers/auth.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/about_us.dart';
import 'package:foodapp/screens/add_food.dart';
import 'package:foodapp/screens/add_trip.dart';
import 'package:foodapp/screens/contact_us.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:foodapp/screens/first_login.dart';
import 'package:foodapp/screens/food.dart';
import 'package:foodapp/screens/leader_board.dart';
import 'package:foodapp/screens/login.dart';
import 'package:foodapp/screens/otp.dart';
import 'package:foodapp/screens/privacy_policy.dart';
import 'package:foodapp/screens/profile_one.dart';
import 'package:foodapp/screens/profile_two.dart';
import 'package:foodapp/screens/register.dart';
import 'package:foodapp/screens/stepper/step_one.dart';
import 'package:foodapp/screens/terms_and_conditions.dart';
import 'package:foodapp/screens/trip.dart';
import 'package:foodapp/utils/shared_preference.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = const Color(0xff50E569)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFE5E5E5),
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data.token == null)
                      return StepOne();
                    else
                      return Home();
                }
              }),
          builder: EasyLoading.init(),
          routes: {
            '/dashboard': (context) => Home(),
            '/login': (context) => Login(),
            '/register': (context) => Register(),
            '/otp': (context) => OTP(),
            // '/profileOne': (context) => ProfileOne(),
            '/travel': (context) => Trip(),
            '/addTravel': (context) => AddTrip(),
            '/food': (context) => Food(),
            '/addFood': (context) => AddFood(),
            '/firstLogin': (context) => FirstLogin(),
          }),
    );
  }
}
