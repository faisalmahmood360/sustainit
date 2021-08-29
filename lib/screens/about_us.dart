import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:foodapp/screens/dashboard.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String descText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like";
  bool descTextShowFlag = false;
  // GoogleMapController mapController;

  // Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  )
                },
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'About Us',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      child: Text('Know more about us')),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/website.svg'),
                            SizedBox(height: 10),
                            Text('Website',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            Text('bookwizard.com')
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/call.svg'),
                            SizedBox(height: 10),
                            Text('Call Us!',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            Text('(123) 345 567890')
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/location.svg'),
                            SizedBox(height: 10),
                            Text('Website',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            Text('New York, NY')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Connect:',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                        SizedBox(width: 10),
                        Image.asset('assets/images/facebook.png'),
                        SizedBox(width: 10),
                        Image.asset('assets/images/instagram.png'),
                        SizedBox(width: 10),
                        SvgPicture.asset('assets/images/twitter.svg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Divider(color: Colors.black),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bio',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      SizedBox(height: 10),
                      Text(descText,
                          maxLines: descTextShowFlag ? 12 : 8,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: 'Source Sans Pro')),
                      InkWell(
                        onTap: () {
                          setState(() {
                            descTextShowFlag = !descTextShowFlag;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            descTextShowFlag
                                ? Text(
                                    "Show Less",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                : Text("Show More",
                                    style: TextStyle(color: Colors.blue))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Our Vision',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      SizedBox(height: 10),
                      Text(descText,
                          maxLines: descTextShowFlag ? 8 : 3,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: 'Source Sans Pro')),
                      InkWell(
                        onTap: () {
                          setState(() {
                            descTextShowFlag = !descTextShowFlag;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            descTextShowFlag
                                ? Text(
                                    "Show Less",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                : Text("Show More",
                                    style: TextStyle(color: Colors.blue))
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  //   height: 200,
                  //   child: GoogleMap(
                  //     initialCameraPosition: CameraPosition(
                  //         target: LatLng(-33.870840, 151.206286), zoom: 12),
                  //   ),
                  // )
                ],
              )),
        ),
      ),
    );
  }
}
