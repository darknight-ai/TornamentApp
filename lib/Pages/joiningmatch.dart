import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Pages/homepage.dart';
import 'package:oneup_noobs/Pages/mainpage.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/utils.dart';

class JoiningMatch extends StatefulWidget {
  final String entryfees;
  final String game;
  final String matchid;
  const JoiningMatch(
      {super.key,
      required this.entryfees,
      required this.game,
      required this.matchid});

  @override
  State<JoiningMatch> createState() => _JoiningMatchState();
}

class _JoiningMatchState extends State<JoiningMatch> {
  late DatabaseReference databaseRef;
  final _nameController = TextEditingController();
  String _userName = 'Add Info';
  bool _showNameField = false;
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          'Joining Match',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.bluecolor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                'assets/wallet.png',
                scale: 1.5,
              ),
              Spacer(),
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    FutureBuilder<String>(
                      future: _walletbalance(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...');
                        } else if (snapshot.hasError) {
                          return Text('Error');
                        } else {
                          return Text(
                            "Your Current Balance: 🪙${snapshot.data}",
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff595a5d),
                              height: 21 / 22,
                            ),
                            textAlign: TextAlign.left,
                          );
                          // Wallettext(
                          //   title: '🪙${snapshot.data}',
                          // );
                        }
                      },
                    ),
                    // Text(
                    //   "Your Current Balance: 🪙 0.00",
                    //   style: const TextStyle(
                    //     fontFamily: "Inter",
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w400,
                    //     color: Color(0xff595a5d),
                    //     height: 21 / 22,
                    //   ),
                    //   textAlign: TextAlign.left,
                    // ),
                  ]),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Match Entry Fee Per Person :🪙${widget.entryfees}",
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff595b5d),
                          height: 23 / 20,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Total Payable Amount : 🪙${widget.entryfees}",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff5a5c5e),
                      height: 23 / 20,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  width: width * 0.94,
                  height: height * 0.0584795321637427,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF73C8B1)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(widget.matchid),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          _showNameDialog(context);
                        },
                        child: Container(
                          width: width * 0.177,
                          height: height * 0.035,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.bluecolor),
                              color: AppColors.bluecolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              _userName,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.15,
          ),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: width * 0.38,
                  height: height * 0.069,
                  decoration: ShapeDecoration(
                    color: Color(0xFFEF7A78),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF8FCCBB)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (_userName == 'Add Info') {
                    // Show error if the user hasn't entered a name
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter your Game User name'),
                      ),
                    );
                  } else {
                    Utils().toastMessage(
                        'Please Wait We are Processing Your Request');
                    _updateWallet(widget.matchid, _userName);
                  }
                },
                child: Container(
                  width: width * 0.38,
                  height: height * 0.069,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5DCDB1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF8FCCBB)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'JOIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          )
        ],
      ),
    );
  }

  Future<String> _walletbalance() async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
      return currentWalletValue.toString();
    } else {
      return '0';
    }
  }

  Future<void> _updateWallet(String matchid, String username) async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
      int currentWallet = int.parse(currentWalletValue);
      int entryFees = int.parse(widget.entryfees);

      if (currentWallet >= entryFees) {
        int updatedWalletValue = currentWallet - entryFees;

        await userDocRef.update({'Wallet': updatedWalletValue.toString()}).then(
          (value) async {
            await userDocRef.update({
              'matches': FieldValue.arrayUnion([matchid])
            }).then((value) {
              databaseRef = FirebaseDatabase.instance.ref(widget.game);
              databaseRef
                  .child(widget.matchid)
                  .child('Participants')
                  .update({username: userDocSnapshot['Email']}).then(
                (value) {
                  setState(() {
                    Utils().toastMessage(
                        'You Had Joined Match Sucessfully.Be on time at the time of Match Room ID will be disclosed');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
                  });
                  ;
                },
              );
            });
          },
        );
      } else {
        // Show insufficient balance message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Insufficient balance to join the match'),
          ),
        );
      }
    }
  }

  void _showNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Your Game Username'),
          content: TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter your Game Username',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                _nameController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                String enteredName = _nameController.text.trim();
                if (enteredName.isNotEmpty) {
                  setState(() {
                    _userName = enteredName;
                  });
                }
                _nameController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
