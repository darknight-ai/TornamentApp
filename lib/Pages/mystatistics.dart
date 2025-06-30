import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class MyStatistics extends StatefulWidget {
  const MyStatistics({super.key});

  @override
  State<MyStatistics> createState() => _MyStatisticsState();
}

class _MyStatisticsState extends State<MyStatistics> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('My Statistics'),
        backgroundColor: AppColors.bluecolor,
      ),
      body: Center(
        child: Container(
          width: width * 0.8,
          height: height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.greencolor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<String>(
                    future: _walletbalance('matches'),
                    builder: (context, snapshot) {
                      return Text(
                        '${snapshot.data}',
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  // Text(
                  //   "0",
                  //   style: const TextStyle(
                  //     fontFamily: "Inter",
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.white,
                  //   ),
                  //   textAlign: TextAlign.right,
                  // ),
                  Text(
                    "Matches",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    "Played",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.04,
              ),
              Container(
                  height: height *
                      0.06, // Adjust the height of the vertical divider
                  width: 1, // Adjust the width of the vertical divider
                  color:
                      Colors.white // Specify the color of the vertical divider
                  ),
              SizedBox(
                width: width * 0.04,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<String>(
                    future: _walletbalance('kills'),
                    builder: (context, snapshot) {
                      return Text(
                        '${snapshot.data}',
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  // Text(
                  //   "0",
                  //   maxLines: 3,
                  //   style: const TextStyle(
                  //     fontFamily: "Inter",
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.white,
                  //   ),
                  //   textAlign: TextAlign.left,
                  // ),
                  Text(
                    "Total",
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Killed",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.04,
              ),
              Container(
                  height: height *
                      0.06, // Adjust the height of the vertical divider
                  width: 1, // Adjust the width of the vertical divider
                  color: Colors.white
                  // Specify the color of the vertical divider
                  ),
              SizedBox(
                width: width * 0.1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "0",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Amount",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Won",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ],
          ),
        ),
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
      if (value == 'matches') {
        List<dynamic> matches = userDocSnapshot.get(value) ?? [];
        return matches.length.toString();
      } else {
        var currentValue = userDocSnapshot[value] ?? '0';
        return currentValue.toString();
      }
    } else {
      return '0';
    }
  }
}
