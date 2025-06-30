import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/utils.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class WithDrawMoney extends StatefulWidget {
  final int accountbalance;
  const WithDrawMoney({super.key, required this.accountbalance});

  @override
  State<WithDrawMoney> createState() => _WithDrawMoneyState();
}

class _WithDrawMoneyState extends State<WithDrawMoney> {
  final amountcontroller = TextEditingController();
  final upiidcontroller = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
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
              controller: amountcontroller,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: 'Enter The Amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TextFormField(
              controller: upiidcontroller,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: 'Enter The Upi Id',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            InkWell(
              onTap: _isLoading
                  ? null // Disable the button if loading
                  : () async {
                      if (int.parse(amountcontroller.text) <
                          widget.accountbalance) {
                        Utils().toastMessage('Proceed');

                        setState(() {
                          _isLoading = true; // Set loading state to true
                        });

                        await _updateWallet();
                        await _withdrawMoney();

                        setState(() {
                          _isLoading = false; // Set loading state to false
                        });
                      } else {
                        Utils().toastMessage('Insufficient Balance');
                      }
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
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Withdraw Money',
                            style: TextStyle(
                              color: Color(0xFFD5FAF5),
                              fontSize: 21,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          )),
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

    int updatedWalletValue =
        (widget.accountbalance) - int.parse(amountcontroller.text);

    await userDocRef.update({'WinMoney': updatedWalletValue}).then(
      (value) {
        Utils().toastMessage(
            'Your Request For Withdrawal is Generated Your account will be shortly Credited with amount');
        nextScreen(context, Wallet());
      },
    );
  }

  Future<void> _withdrawMoney() async {
    // Get the user's email from the authentication type
    String userEmail = checkUserAuthenticationType();

    // Get the current date and time
    DateTime now = DateTime.now();
    String id = DateTime.now().microsecondsSinceEpoch.toString();

    // Create a transaction history document
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmail)
        .collection('TransactionHistory')
        .doc(id)
        .set({
      'amount': amountcontroller
          .text, // Replace with the actual amount to be withdrawn
      'date': now,
      'UPIID': upiidcontroller.text,
      'transactionStatus': false,
    });
    await FirebaseFirestore.instance.collection('Transactions').doc(id).set({
      'amount': amountcontroller
          .text, // Replace with the actual amount to be withdrawn
      'date': now,
      'UPIID': upiidcontroller.text,
      'email': userEmail,
      'transactionStatus': false,
    });

    Utils().toastMessage('Withdrawal request submitted');
  }
}
