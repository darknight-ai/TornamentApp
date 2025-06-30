import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/utils.dart';
import 'package:oneup_noobs/Utils/widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Paymentgatway extends StatefulWidget {
  const Paymentgatway({super.key});

  @override
  State<Paymentgatway> createState() => _PaymentgatwayState();
}

class _PaymentgatwayState extends State<Paymentgatway> {
  final amountcontrolller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('Users').snapshots();
  final _razorpay = Razorpay();
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Utils().toastMessage(response.paymentId.toString());
      _updateWallet();

    // searchAndCreateCourse1();
    nextScreen(context, Wallet());

    // Do something when payment succeeds

    // ref.doc(auth.currentUser!.email.toString()).update({'UID': "1234567"});
    //  searchAndCreateCourse1(widget.coursename);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils().toastMessage('Payment Failed');
  

    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Wallet(),
    //     ));
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utils().toastMessage('Please Do Not Choose External Wallet');
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Add Money',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.bluecolor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            TextFormField(
              controller: amountcontrolller,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: 'Enter The Amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            InkWell(
              onTap: () {
                var options = {
                  'key': 'rzp_live_Jn3dR4S4ULXrkH',
                  'amount': int.parse(amountcontrolller.text.toString()) *
                      100, //in the smallest currency sub-unit.
                  'name': 'demo', // Generate order_id using Orders API
                  'description': 'demo',
                  'timeout': 240, // in seconds

                  // 'prefill': {
                  //   'contact': '8102043143',
                  //   'email': 'examtymapp@gmail.com'
                  // }
                };
                _razorpay.open(options);
              },
              child: Container(
                width: width * 0.758,
                height: height * 0.0697,
                decoration: ShapeDecoration(
                  color: Color(0xFF5DCDB1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF8AC8B8)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Center(
                  child: Text(
                    'ADD MONEY',
                    style: TextStyle(
                      color: Color(0xFFD5FAF5),
                      fontSize: 21,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateWallet() async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
      int updatedWalletValue =
          int.parse(currentWalletValue) + int.parse(amountcontrolller.text);

      await userDocRef.update({'Wallet': updatedWalletValue.toString()}).then(
        (value) {
          nextScreen(context, Wallet());
        },
      );
    }
  }
}
