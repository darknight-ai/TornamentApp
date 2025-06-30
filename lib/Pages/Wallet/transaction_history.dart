import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oneup_noobs/Pages/Wallet/components/transactionhistorytile.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
          'Withdrawal History',
        ),
        backgroundColor: AppColors.bluecolor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _fetchTransactionHistory(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No transaction history found.'),
                  );
                }

                List<DocumentSnapshot> sortedDocs =
                    snapshot.data!.docs.toList();
                sortedDocs.sort((a, b) {
                  Timestamp timestampA = a['date'];
                  Timestamp timestampB = b['date'];
                  return timestampB.compareTo(timestampA);
                });

                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemCount: sortedDocs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = sortedDocs[index];
                    Timestamp timestamp = document['date'];
                    DateTime dateTime = timestamp.toDate();
                    String formattedDate =
                        DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);

                    return Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.03, right: width * 0.02),
                      child: TransactionHistoryTile(
                        amount: document['amount'],
                        upiid: document['UPIID'],
                        sucess: document['transactionStatus'],
                        date: formattedDate,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _fetchTransactionHistory() {
    String userEmail = checkUserAuthenticationType();
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmail)
        .collection('TransactionHistory')
        .snapshots();
  }
}
