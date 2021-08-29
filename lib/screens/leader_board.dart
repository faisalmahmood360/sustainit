import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/models/ApiModels/LeaderBoardModel.dart';
import 'package:http/http.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Loading...');
    leaderBoardDetailSubmit();
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
  }

  LeaderBoardModel leaderBoardModel;

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
                  'Leaderboard',
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
                      leaderBoardModel == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(children: [
                                    Text(
                                      '2nd',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5),
                                    Image.asset(
                                        'assets/images/persons/first.png'),
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
                                      Image.asset(
                                          'assets/images/persons/second.png'),
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5),
                                    Image.asset(
                                        'assets/images/persons/third.png'),
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
                        child: Container(
                          height: 100,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                print('leader board: ${leaderBoardModel}');
                                // return vegetarianCard(
                                //     leaderBoardModel.vegetarian.the1.image,
                                //     leaderBoardModel.vegetarian.the1.name,
                                //     leaderBoardModel.vegetarian.the1.userName,
                                //     leaderBoardModel.vegetarian.the1.score
                                //         .toString());
                              }),
                        ),
                      )

                      // Expanded(
                      //   child: ListView(
                      //     children: <Widget>[
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image1.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_1.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('7.1K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image2.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_2.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('8.1K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image3.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_3.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('4.51K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image1.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_2.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('8.1K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image2.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_3.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('4.1K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image3.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_1.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('2.61K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image1.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_3.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('5.1K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image2.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_1.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('5.1K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(children: [
                      //             Image.asset(
                      //                 'assets/images/persons/image3.png'),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('Joyce',
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.w700)),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/images/persons/flag_2.svg'),
                      //                     SizedBox(width: 3),
                      //                     Text('@horaceperry')
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ]),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text('2.1K',
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700)),
                      //               Text('score')
                      //             ],
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
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
                      // ListView.builder(
                      //     itemCount: leaderBoardModel.vagens.length,
                      //     itemBuilder: (context,index){
                      //       return vegetarianCard(leaderBoardModel.vagens,leaderBoardModel.vegetarian.the1.name,leaderBoardModel.vegetarian.the1.userName,leaderBoardModel.vegetarian.the1.score);
                      //     })
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

  vegetarianCard(img, name, userName, score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Container(
            height: 50,
            width: 50,
            child: Image.asset(img),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  // SvgPicture.asset(
                  //     'assets/images/persons/flag_2.svg'),
                  SizedBox(width: 3),
                  Text(userName)
                ],
              ),
            ],
          ),
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(score,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('score')
          ],
        ),
      ],
    );
  }

  leaderBoardDetailSubmit() async {
    var apis = ApiManager();
    Response response = await apis.getLeaderboardDetailApi();
    if (response.statusCode == 200) {
      leaderBoardModel = LeaderBoardModel.fromJson(jsonDecode(response.body));
      setState(() {});
    }
  }
}
