import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Compete extends StatefulWidget {
  @override
  _CompeteState createState() => _CompeteState();
}

class _CompeteState extends State<Compete> {
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Loading...');

    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: SvgPicture.asset('assets/images/back_icon.svg'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  'Compete',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 0,
                bottom: TabBar(
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff50E569),
                    ),
                    tabs: [
                      Tab(text: 'Vegetarians'),
                      Tab(text: 'Vegans'),
                      Tab(text: 'Omnivores'),
                    ]),
              ),
              body: TabBarView(children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/today.svg'),
                          Text(
                            ' Today',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: 20.0),
                          SvgPicture.asset('assets/images/30_days.svg'),
                          Text(
                            ' 30 Days',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  '2nd',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Image.asset('assets/images/persons/first.png'),
                                SizedBox(height: 5),
                                Text('Horace',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/persons/flag_1.svg'),
                                    SizedBox(width: 3),
                                    Text('@horaceperry')
                                  ],
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Column(
                                    children: [
                                      Text('2.3K',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Text('Score')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 18.0),
                              child: Column(children: [
                                Text(
                                  '1st',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Image.asset('assets/images/persons/second.png'),
                                SizedBox(height: 5),
                                Text('Kevin',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/persons/flag_2.svg'),
                                    SizedBox(width: 3),
                                    Text('@kevinbryne')
                                  ],
                                ),
                                SizedBox(height: 10),
                                Center(
                                    child: Column(
                                  children: [
                                    Text('2.2K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('Score')
                                  ],
                                ))
                              ]),
                            ),
                          ),
                          Flexible(
                            child: Column(children: [
                              Text(
                                '2nd',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Image.asset('assets/images/persons/third.png'),
                              SizedBox(height: 5),
                              Text('Lorna',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/persons/flag_3.svg'),
                                  SizedBox(width: 3),
                                  Text('lornaratliff')
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Column(
                                children: [
                                  Text('2.4K',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  Text('Score')
                                ],
                              ))
                            ]),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('7.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('8.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('4.51K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('8.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('4.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('2.61K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('5.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('5.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('2.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/today.svg'),
                          Text(
                            ' Today',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: 20.0),
                          SvgPicture.asset('assets/images/30_days.svg'),
                          Text(
                            ' 30 Days',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(children: [
                              Text(
                                '2nd',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Image.asset('assets/images/persons/first.png'),
                              SizedBox(height: 5),
                              Text('Horace',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/persons/flag_1.svg'),
                                  SizedBox(width: 3),
                                  Text('@horaceperry')
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Column(
                                children: [
                                  Text('2.3K',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  Text('Score')
                                ],
                              ))
                            ]),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 18.0),
                              child: Column(children: [
                                Text(
                                  '1st',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Image.asset('assets/images/persons/second.png'),
                                SizedBox(height: 5),
                                Text('Kevin',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/persons/flag_2.svg'),
                                    SizedBox(width: 3),
                                    Text('@kevinbryne')
                                  ],
                                ),
                                SizedBox(height: 10),
                                Center(
                                    child: Column(
                                  children: [
                                    Text('2.2K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('Score')
                                  ],
                                ))
                              ]),
                            ),
                          ),
                          Flexible(
                            child: Column(children: [
                              Text(
                                '2nd',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Image.asset('assets/images/persons/third.png'),
                              SizedBox(height: 5),
                              Text('Lorna',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/persons/flag_3.svg'),
                                  SizedBox(width: 3),
                                  Text('lornaratliff')
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Column(
                                children: [
                                  Text('2.4K',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  Text('Score')
                                ],
                              ))
                            ]),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('7.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('8.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('4.51K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('8.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('4.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('2.61K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('5.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('5.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('2.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/today.svg'),
                          Text(
                            ' Today',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: 20.0),
                          SvgPicture.asset('assets/images/30_days.svg'),
                          Text(
                            ' 30 Days',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(children: [
                              Text(
                                '2nd',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Image.asset('assets/images/persons/first.png'),
                              SizedBox(height: 5),
                              Text('Horace',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/persons/flag_1.svg'),
                                  SizedBox(width: 3),
                                  Text('@horaceperry')
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Column(
                                children: [
                                  Text('2.3K',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  Text('Score')
                                ],
                              ))
                            ]),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 18.0),
                              child: Column(children: [
                                Text(
                                  '1st',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Image.asset('assets/images/persons/second.png'),
                                SizedBox(height: 5),
                                Text('Kevin',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/persons/flag_2.svg'),
                                    SizedBox(width: 3),
                                    Text('@kevinbryne')
                                  ],
                                ),
                                SizedBox(height: 10),
                                Center(
                                    child: Column(
                                  children: [
                                    Text('2.2K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('Score')
                                  ],
                                ))
                              ]),
                            ),
                          ),
                          Flexible(
                            child: Column(children: [
                              Text(
                                '2nd',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Image.asset('assets/images/persons/third.png'),
                              SizedBox(height: 5),
                              Text('Lorna',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/persons/flag_3.svg'),
                                  SizedBox(width: 3),
                                  Text('lornaratliff')
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Column(
                                children: [
                                  Text('2.4K',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  Text('Score')
                                ],
                              ))
                            ]),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('7.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('8.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('4.51K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('8.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('4.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('2.61K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image1.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_3.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('5.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image2.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_1.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('5.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                      'assets/images/persons/image3.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Joyce',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/persons/flag_2.svg'),
                                          SizedBox(width: 3),
                                          Text('@horaceperry')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('2.1K',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    Text('score')
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
