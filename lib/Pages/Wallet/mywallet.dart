import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Pages/Wallet/components/walletbutton.dart';
import 'package:oneup_noobs/Pages/Wallet/components/wallettext.dart';
import 'package:oneup_noobs/Pages/Wallet/paymentgateway.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Pages/Wallet/withdrawmoney.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/utils.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int _winMoneyBalance = 0;
  @override
  void initState() {
    // TODO: implement initState
    _getWinMoneyBalance();
    super.initState();
  }

  void _getWinMoneyBalance() async {
    int winMoneyBalance = await _winbalance('WinMoney');
    setState(() {
      _winMoneyBalance = winMoneyBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.bluecolor,
        title: Text(
          'My Wallet',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.01220,
          ),
          Center(
            child: Container(
              // height: height * 0.198,
              width: width * 0.9625,
              child: Column(
                children: [
                  Container(
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
                        'TOTAL BALANCE',
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
                  Container(
                    width: width * 0.9625,
                    height: height * 0.155,
                    color: Color(0xffADE5D7),
                    child: Center(
                      child: Column(children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/coin.png',
                                        scale: 20,
                                      ),
                                      FutureBuilder<String>(
                                        future: _walletbalance('Wallet'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Wallettext(
                                              title: 'Loading...',
                                            );
                                          } else if (snapshot.hasError) {
                                            return Wallettext(
                                              title: 'Error',
                                            );
                                          } else {
                                            return Wallettext(
                                              title: '${snapshot.data}',
                                            );
                                          }
                                        },
                                      ),
                                    ]),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                FutureBuilder<String>(
                                  future: _walletbalance('WinMoney'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Wallettext(
                                        title: 'Loading...',
                                      );
                                    } else if (snapshot.hasError) {
                                      return Wallettext(
                                        title: 'Error',
                                      );
                                    } else {
                                      return Wallettext(
                                        title: 'Win money : ${snapshot.data}',
                                      );
                                    }
                                  },
                                ),
                                // Wallettext(
                                //   title: 'Win money : 0.00',
                                // ),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                Wallettext(
                                  title: 'Join money : 0.00',
                                )
                              ],
                            ),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Column(
                              children: [
                                Walletbutton(
                                  ontap: () {
                                    nextScreen(context, Paymentgatway());
                                  },
                                  title: 'Add',
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Walletbutton(
                                  ontap: () {
                                    if (_winMoneyBalance > 100) {
                                      nextScreen(
                                          context,
                                          WithDrawMoney(
                                              accountbalance:
                                                  _winMoneyBalance));
                                    }
                                    if (_winMoneyBalance <= 100) {
                                      Utils().toastMessage(
                                          'To Withdraw balance should be minimum 100');
                                    }
                                    // print(_winMoneyBalance);
                                    // if (int.parse(_winMoneyBalance) > 100) {
                                    //   Utils().toastMessage('Withdraw');
                                    // }
                                  },
                                  title: 'Withdraw',
                                )
                              ],
                            ),
                            Spacer()
                          ],
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(children: [
            Spacer(),
            Container(
              // height: height * 0.198,
              width: width * 0.4625,
              child: Column(
                children: [
                  Container(
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
                        'Earnings',
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
                  Container(
                    width: width * 0.9625,
                    height: height * 0.07,
                    color: Color(0xffADE5D7),
                    child: Center(
                      child: Column(children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
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
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              // height: height * 0.198,
              width: width * 0.4625,
              child: Column(
                children: [
                  Container(
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
                        'Payouts',
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
                  Container(
                    width: width * 0.9625,
                    height: height * 0.07,
                    color: Color(0xffADE5D7),
                    child: Center(
                      child: Column(children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
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
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Spacer()
          ]),
        ],
      ),
    );
  }

  Future<String> _walletbalance(String value) async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot[value] ?? '0';
      return currentWalletValue.toString();
    } else {
      return '0';
    }
  }

  Future<int> _winbalance(String value) async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot[value] ?? '0';
      return currentWalletValue;
    } else {
      return 0;
    }
  }
}
