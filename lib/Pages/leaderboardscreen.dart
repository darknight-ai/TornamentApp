import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final Stream<QuerySnapshot> _referalsStream =
      FirebaseFirestore.instance.collection('Referals').snapshots();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
        foregroundColor: Colors.white,
        title: Text('Leaderboard'),
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

              // Safeguard and debug: Check the types of 'count' fields
              documents.forEach((doc) {
                dynamic count = doc.get('count');
                if (count is! int) {
                  print('Invalid count type for document ${doc.id}: $count');
                }
              });

              // Sort documents based on the 'count' field
              documents.sort((a, b) {
                int countA = a.get('count') is int ? a.get('count') : 0;
                int countB = b.get('count') is int ? b.get('count') : 0;
                return countB.compareTo(countA); // Descending order
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
                        'Total Referal',
                        style: TextStyle(color: Colors.white),
                      )),
                    ],
                    rows: documents.map((document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return DataRow(
                        cells: [
                          DataCell(Text(data['Email'] ?? 'N/A',
                              style: TextStyle(fontWeight: FontWeight.w600))),
                          DataCell(Text((data['count'] ?? 0).toString(),
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
