import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/screens/login.dart';
import 'package:foodapp/screens/register.dart';
import 'package:foodapp/screens/stepper/step_four.dart';

class StepFive extends StatefulWidget {
  @override
  _StepFiveState createState() => _StepFiveState();
}

class _StepFiveState extends State<StepFive> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 180),
            Expanded(
              child: Center(
                child: SvgPicture.asset('assets/images/stepper/step5.svg'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  Text(
                    'Achieve',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF50E569)),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt donec sed ligula amet bibendum tempus imperdiet tempor nullam. Laoreet vel in non cras et mattis senectus a, ut...',
                    textAlign: TextAlign.center,
                    style: TextStyle(letterSpacing: 0.50),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: RaisedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StepFour()),
                            )
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: SvgPicture.asset(
                              'assets/images/stepper/back.svg'),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: RaisedButton(
                          color: Color(0xff50E569),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            )
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: SvgPicture.asset(
                              'assets/images/stepper/next.svg'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
