import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class TopPlayers extends StatefulWidget {
  const TopPlayers({super.key});

  @override
  State<TopPlayers> createState() => _TopPlayersState();
}

class _TopPlayersState extends State<TopPlayers> {
  final Stream<QuerySnapshot> _referalsStream =
      FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
        foregroundColor: Colors.white,
        title: Text('Top Players'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: _referalsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

              // Safeguard and debug: Check the types of 'Wallet' fields
              documents.forEach((doc) {
                dynamic wallet = doc.get('Wallet');
                if (wallet is! String) {
                  print('Invalid wallet type for document ${doc.id}: $wallet');
                }
              });

              // Sort documents based on the 'Wallet' field
              documents.sort((a, b) {
                double walletA = double.tryParse(a.get('Wallet')) ?? 0.0;
                double walletB = double.tryParse(b.get('Wallet')) ?? 0.0;
                return walletB.compareTo(walletA); // Descending order
              });

              return SingleChildScrollView(
                child: Container(
                  width: width,
                  child: DataTable(
                    headingRowHeight: height * 0.06,
                    headingRowColor:
                        MaterialStatePropertyAll(AppColors.greencolor),
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Username',
                        style: TextStyle(color: Colors.white),
                      )),
                      DataColumn(
                          label: Text(
                        'Winning',
                        style: TextStyle(color: Colors.white),
                      )),
                    ],
                    rows: documents.map((document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            data['Name'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                          DataCell(Text("🪙 " + data['Wallet'] ?? '0',
                              style: TextStyle(fontWeight: FontWeight.w600))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
