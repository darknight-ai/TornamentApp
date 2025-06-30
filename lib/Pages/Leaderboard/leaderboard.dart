import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/minorcomponents/tournamentdetails_container.dart';

class Leaderboard extends StatefulWidget {
  final String gamename;
  final String matchid;
  final String map;
  final String entryfees;
  final String team;
  final String date;
  final String time;
  final String prizepool;
  final String perkill;

  final String game;
  final String img;
  final String matchtitle;

  const Leaderboard(
      {super.key,
      required this.gamename,
      required this.matchid,
      required this.map,
      required this.entryfees,
      required this.team,
      required this.date,
      required this.time,
      required this.prizepool,
      required this.perkill,
      required this.game,
      required this.img,
      required this.matchtitle});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late DatabaseReference participantsRef;
  late Stream<DatabaseEvent> participantsStream;

  @override
  void initState() {
    super.initState();
    participantsRef = FirebaseDatabase.instance
        .ref()
        .child(widget.gamename)
        .child(widget.matchid)
        .child('Kills');
    participantsStream = participantsRef.onValue;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Match Results'),
        foregroundColor: Colors.white,
        backgroundColor: AppColors.bluecolor,
      ),
      body: Column(
        children: [
          Column(children: [
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: Container(
                width: width * 0.953,
                height: height * 0.229,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.img),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: height * 0.015,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      widget.matchtitle,
                      style: TextStyle(
                        color: AppColors.greencolor,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      TournamentDetailsContainer(
                        title: 'Team',
                        value: widget.team,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      TournamentDetailsContainer(
                        title: 'Entry Fee 🪙',
                        value: widget.entryfees,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      TournamentDetailsContainer(
                        title: 'Match Schedule',
                        value: '${widget.date} ${widget.time}',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Row(children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                  ]),
                  // SizedBox(
                  //   height: height * 0.015,
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      TournamentDetailsContainer(
                        title: 'WinningPrize',
                        value: widget.prizepool,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      TournamentDetailsContainer(
                        title: 'Per Kill',
                        value: widget.perkill,
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: height * 0.001,
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: participantsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic>? participantsMap =
                      snapshot.data?.snapshot.value as Map?;
                  if (participantsMap != null) {
                    List<MapEntry<dynamic, dynamic>> participantsList =
                        participantsMap.entries.toList();
                    int rowNum = 0;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.93,
                          height: height * 0.05,
                          decoration: ShapeDecoration(
                            color: Color(0xFF5ECDB1),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFF73C8B1)),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Match Results',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 40, 40, 40),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFF73C8B1)),
                              ),
                            ),
                            child: Container(
                              width: width * 0.93,
                              child: DataTable(
                                headingRowHeight: height * 0.05,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    '#',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Player Name',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text('Kills',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ],
                                rows: participantsList.map((participant) {
                                  String uid = participant.key.toString();
                                  Map<dynamic, dynamic> participantData =
                                      participant.value;
                                  String email = participantData['Email'];
                                  String kills =
                                      participantData['Killing'].toString();
                                  rowNum++; // Increment the row number

                                  return DataRow(
                                    color:
                                        MaterialStateProperty.all(Colors.white),
                                    cells: [
                                      DataCell(Text(rowNum.toString())),
                                      DataCell(Text(uid)),
                                      DataCell(Text(kills.toString())),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
