import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class MyRewards extends StatefulWidget {
  const MyRewards({super.key});

  @override
  State<MyRewards> createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  List<String> referalList = [];
  String referalId = '';

  @override
  void initState() {
    super.initState();
    fetchReferals();
    _referalid().then(
      (value) {
        setState(() {
          referalId = value;
        });
      },
    );
  }

  Future<void> fetchReferals() async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      List<dynamic>? referals = userDocSnapshot['MyRewards'];
      if (referals != null) {
        setState(() {
          referalList = referals.cast<String>().toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('My Rewards'),
        backgroundColor: AppColors.bluecolor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Center(
          //     child: Container(
          //         width: width * 0.94,
          //         height: height * 0.05,
          //         decoration: ShapeDecoration(
          //           color: Color(0xFF5ECDB1),
          //           shape: RoundedRectangleBorder(
          //             side: BorderSide(width: 1, color: Color(0xFF73C8B1)),
          //           ),
          //         ),
          //         child: Center(
          //             child: Text('My Referals Summary',
          //                 style: TextStyle(color: Colors.white))))),
          Container(
            // height: height * 0.198,
            width: width * 0.9625,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: Container(
                    width: width * 0.9625,
                    height: height * 0.0437,
                    decoration: ShapeDecoration(
                      color: Color(0xFF5FCCB1),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF75C7B3)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'My Referals Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9625,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF75C7B3)),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ),
                  // height: height * 0.07,
                  //color: Colors.white,
                  child: Center(
                    child: Column(children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Column(children: [
                              Text('Rewards'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder<String>(
                                    future: _referalcounts(referalId),
                                    builder: (context, snapshot) {
                                      return Text(
                                        '${snapshot.data}',
                                        style: TextStyle(
                                          color: Color(0xFF344F4C),
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                          height: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ]),
                            Spacer(),
                            Column(children: [
                              Text('Earnings'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/coin.png',
                                    scale: 20,
                                  ),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Color(0xFF344F4C),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              )
                            ]),
                            Spacer()
                          ]),
                    ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: Container(
              decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 40, 40, 40),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF73C8B1)),
                ),
              ),
              child: Container(
                width: width * 0.94,
                height: height * 0.05,
                decoration: ShapeDecoration(
                  color: Color(0xFF5ECDB1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF73C8B1)),
                  ),
                ),
                child: Center(
                  child: Text(
                    'My Rewards List',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: referalList.isNotEmpty
                ? Container(
                    width: width * 0.95,
                    child: DataTable(
                      headingRowHeight: height * 0.05,
                      headingRowColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 40, 40, 40)),
                      columns: [
                        DataColumn(
                            label: Text(
                          'S.no',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text('Reward ID',
                                style: TextStyle(color: Colors.white))),
                        DataColumn(
                            label: Text('Status',
                                style: TextStyle(color: Colors.white))),
                      ],
                      rows: referalList
                          .map(
                            (referal) => DataRow(
                              color: MaterialStateProperty.all(Colors.white),
                              cells: [
                                DataCell(Text('1')),
                                DataCell(Text(referal)),
                                DataCell(Text('✅'))
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  )
                : const Center(
                    child: Text('No data present'),
                  ),
          ),
        ],
      ),
    );
  }

  Future<String> _referalid() async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['ReferalId'] ?? '0';
      return currentWalletValue.toString();
    } else {
      return '0';
    }
  }

  Future<String> _referalcounts(String id) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('Referals').doc(id);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['count'] ?? '0';
      return currentWalletValue.toString();
    } else {
      return '0';
    }
  }
}
